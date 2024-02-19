/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package aplikasi_ojek_online;

import Connection.koneksi;
import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.event.MouseAdapter;
import java.sql.Connection;
import java.sql.SQLException;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.plaf.basic.BasicScrollBarUI;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.JTableHeader;
import org.w3c.dom.events.MouseEvent;
import javax.swing.table.TableColumnModel;
import com.formdev.flatlaf.extras.FlatSVGIcon;

/**
 *
 * @author oditr
 */
public class Aplikasi extends javax.swing.JFrame {





    /**
     * Creates new form Aplikasi
     */

    // Custom ScrollBarUI
    private class CustomScrollBarUI extends BasicScrollBarUI {
        private final Color thumbColor = new Color(69, 115, 255); // RGB: (69, 115, 255)

        @Override
        protected JButton createDecreaseButton(int orientation) {
            return createButton();
        }

        @Override
        protected JButton createIncreaseButton(int orientation) {
            return createButton();
        }

        private JButton createButton() {
            JButton button = new JButton();
            button.setBorderPainted(false);
            button.setContentAreaFilled(false);
            button.setFocusPainted(false);
            button.setOpaque(false);
            return button;
        }

        @Override
        protected void paintThumb(Graphics g, JComponent c, Rectangle thumbBounds) {
            g.setColor(thumbColor);
            ((Graphics2D) g).fill(thumbBounds);
        }

        @Override
        protected void paintTrack(Graphics g, JComponent c, Rectangle trackBounds) {
            // Leave track empty or customize as needed
        }
    }
    
    private void setColumnWidth_booking() {
        TableColumnModel columnModel = tabelData.getColumnModel();
        columnModel.getColumn(0).setPreferredWidth(30);
        columnModel.getColumn(0).setMaxWidth(30);
        columnModel.getColumn(0).setMinWidth(30);
        
        columnModel.getColumn(1).setPreferredWidth(110);
        columnModel.getColumn(1).setMaxWidth(110);
        columnModel.getColumn(1).setMinWidth(110);
        
        columnModel.getColumn(2).setPreferredWidth(90);
        columnModel.getColumn(2).setMaxWidth(90);
        columnModel.getColumn(2).setMinWidth(90);
        
        columnModel.getColumn(3).setPreferredWidth(105);
        columnModel.getColumn(3).setMaxWidth(105);
        columnModel.getColumn(3).setMinWidth(105);
        
        columnModel.getColumn(4).setPreferredWidth(90);
        columnModel.getColumn(4).setMaxWidth(90);
        columnModel.getColumn(4).setMinWidth(90);
        
        columnModel.getColumn(5).setPreferredWidth(85);
        columnModel.getColumn(5).setMaxWidth(85);
        columnModel.getColumn(5).setMinWidth(85);
        
        columnModel.getColumn(6).setPreferredWidth(70);
        columnModel.getColumn(6).setMaxWidth(70);
        columnModel.getColumn(6).setMinWidth(70);
        
        JTableHeader header = tabelData.getTableHeader();
        header.setFont(new Font("Lato", Font.BOLD, 12));
         header.setBackground(new Color(245, 246, 250));
    }
    
    private void setColumnWidth_passenger() {
        TableColumnModel columnModel = tabelData.getColumnModel();
        columnModel.getColumn(0).setPreferredWidth(30);
        columnModel.getColumn(0).setMaxWidth(30);
        columnModel.getColumn(0).setMinWidth(30);
        
        columnModel.getColumn(1).setPreferredWidth(150);
        columnModel.getColumn(1).setMaxWidth(150);
        columnModel.getColumn(1).setMinWidth(150);
        
        columnModel.getColumn(2).setPreferredWidth(40);
        columnModel.getColumn(2).setMaxWidth(40);
        columnModel.getColumn(2).setMinWidth(40);
        
        columnModel.getColumn(3).setPreferredWidth(110);
        columnModel.getColumn(3).setMaxWidth(110);
        columnModel.getColumn(3).setMinWidth(110);
        
        columnModel.getColumn(4).setPreferredWidth(115);
        columnModel.getColumn(4).setMaxWidth(115);
        columnModel.getColumn(4).setMinWidth(115);
        
        columnModel.getColumn(5).setPreferredWidth(140);
        columnModel.getColumn(5).setMaxWidth(140);
        columnModel.getColumn(5).setMinWidth(140);
        
        JTableHeader header = tabelData.getTableHeader();
        header.setFont(new Font("Lato", Font.BOLD, 12));
         header.setBackground(new Color(245, 246, 250));
        
    }
    
    private void setColumnWidth_driver() {
        TableColumnModel columnModel = tabelData.getColumnModel();
        columnModel.getColumn(0).setPreferredWidth(30);
        columnModel.getColumn(0).setMaxWidth(30);
        columnModel.getColumn(0).setMinWidth(30);
        
        columnModel.getColumn(1).setPreferredWidth(150);
        columnModel.getColumn(1).setMaxWidth(150);
        columnModel.getColumn(1).setMinWidth(150);
        
        columnModel.getColumn(2).setPreferredWidth(50);
        columnModel.getColumn(2).setMaxWidth(50);
        columnModel.getColumn(2).setMinWidth(50);
        
        columnModel.getColumn(3).setPreferredWidth(110);
        columnModel.getColumn(3).setMaxWidth(110);
        columnModel.getColumn(3).setMinWidth(110);
        
        columnModel.getColumn(4).setPreferredWidth(120);
        columnModel.getColumn(4).setMaxWidth(120);
        columnModel.getColumn(4).setMinWidth(120);
        
        columnModel.getColumn(5).setPreferredWidth(140);
        columnModel.getColumn(5).setMaxWidth(140);
        columnModel.getColumn(5).setMinWidth(140);
        
        JTableHeader header = tabelData.getTableHeader();
        header.setFont(new Font("Lato", Font.BOLD, 12));
         header.setBackground(new Color(245, 246, 250));
        
        
    }
    
    private void tampilkan_data_overview()
    {
        DefaultTableModel model = new DefaultTableModel();
        model.addColumn("No.");
        model.addColumn("Name Driver");
        model.addColumn("Driver License");
        model.addColumn("Name Passenger");
        model.addColumn("Start Location");
        model.addColumn("End Location");
        model.addColumn("Status");
        
        
        try{
            int no = 1;
            String sql = "SELECT d.name, d.license_number, p.name, r.start_location, r.end_location, b.status \n" +
            "FROM booking b \n" +
            "JOIN driver d ON b.driver_id = d.driver_id\n" +
            "JOIN passenger p ON b.passenger_id = p.passenger_id\n" +
            "JOIN schedule s ON s.schedule_id = b.schedule_id\n" +
            "JOIN route r ON r.route_id = s.route_id";
            java.sql.Connection conn = (Connection) koneksi.getConnection();
            java.sql.Statement stm = conn.createStatement();
            java.sql.ResultSet res = stm.executeQuery(sql);
            
            while(res.next())
            {
                model.addRow(new Object[]{no++, res.getString(1), res.getString(2), res.getString(3), res.getString(4), res.getString(5), res.getString(6)});
                
            }
            tabelData.setModel(model);
            tabelData.setBackground(Color.WHITE);
            setColumnWidth_booking();
            jScrollPane1.getVerticalScrollBar().setUI(new CustomScrollBarUI());
            
            
        }catch (SQLException e)
        {
            System.out.println("Error : " + e.getMessage());
        }
    }
    
    private void tampilkan_data_booking()
    {
        DefaultTableModel model = new DefaultTableModel();
        model.addColumn("No.");
        model.addColumn("Name Driver");
        model.addColumn("Driver License");
        model.addColumn("Name Passenger");
        model.addColumn("Start Location");
        model.addColumn("End Location");
        model.addColumn("Status");
        
        
        try{
            int no = 1;
            String sql = "SELECT d.name, d.license_number, p.name, r.start_location, r.end_location, b.status \n" +
            "FROM booking b \n" +
            "JOIN driver d ON b.driver_id = d.driver_id\n" +
            "JOIN passenger p ON b.passenger_id = p.passenger_id\n" +
            "JOIN schedule s ON s.schedule_id = b.schedule_id\n" +
            "JOIN route r ON r.route_id = s.route_id\n" +
            "WHERE b.status = 'Confirmed'";
            java.sql.Connection conn = (Connection) koneksi.getConnection();
            java.sql.Statement stm = conn.createStatement();
            java.sql.ResultSet res = stm.executeQuery(sql);
            
            while(res.next())
            {
                model.addRow(new Object[]{no++, res.getString(1), res.getString(2), res.getString(3), res.getString(4), res.getString(5), res.getString(6)});
                
            }
            tabelData.setModel(model);
            tabelData.setBackground(Color.WHITE);
            setColumnWidth_booking();
            jScrollPane1.getVerticalScrollBar().setUI(new CustomScrollBarUI());
        }catch (SQLException e)
        {
            System.out.println("Error : " + e.getMessage());
        }
    }
    
    private void tampilkan_data_driver()
    {
        DefaultTableModel model = new DefaultTableModel();
        model.addColumn("No.");
        model.addColumn("Name Driver");
        model.addColumn("Age");
        model.addColumn("Gender");
        model.addColumn("Contact Driver");
        model.addColumn("License Number");
        
        
        try{
            int no = 1;
            String sql = "SELECT driver.name, driver.age, driver.gender, driver.contact_number, driver.license_number\n" +
            "FROM driver";
            
            java.sql.Connection conn = (Connection) koneksi.getConnection();
            java.sql.Statement stm = conn.createStatement();
            java.sql.ResultSet res = stm.executeQuery(sql);
            
            while(res.next())
            {
                model.addRow(new Object[]{no++, res.getString(1), res.getString(2),res.getString(3), res.getString(4), res.getString(5)});
                
            }
            tabelData.setModel(model);
            tabelData.setBackground(Color.WHITE);
            setColumnWidth_driver();
            jScrollPane1.getVerticalScrollBar().setUI(new CustomScrollBarUI());
        }catch (SQLException e)
        {
            System.out.println("Error : " + e.getMessage());
        }
    }
    
    private void tampilkan_data_passenger()
    {
        DefaultTableModel model = new DefaultTableModel();
        model.addColumn("No.");
        model.addColumn("Name Passenger");
        model.addColumn("Age");
        model.addColumn("Gender");
        model.addColumn("Contact Passenger");
        model.addColumn("Email Passenger");
        
        
        try{
            int no = 1;
            String sql = "SELECT passenger.name, passenger.age, passenger.gender, passenger.contact_number, passenger.email\n" +
"FROM passenger";
            
            java.sql.Connection conn = (Connection) koneksi.getConnection();
            java.sql.Statement stm = conn.createStatement();
            java.sql.ResultSet res = stm.executeQuery(sql);
            
            while(res.next())
            {
                model.addRow(new Object[]{no++, res.getString(1), res.getString(2),res.getString(3), res.getString(4), res.getString(5)});
                
            }
            tabelData.setModel(model);
            tabelData.setBackground(Color.WHITE);
            setColumnWidth_passenger();
            jScrollPane1.getVerticalScrollBar().setUI(new CustomScrollBarUI());
        }catch (SQLException e)
        {
            System.out.println("Error : " + e.getMessage());
        }
    }
    
    
    
    
    public class GradientPanel extends JPanel {

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);

        Graphics2D g2d = (Graphics2D) g;

        // Warna atas (awal gradasi)
        Color colorAtas = new Color(65, 101, 228); // Ganti dengan warna yang Anda inginkan

        // Warna bawah (akhir gradasi)
        Color colorBawah = new Color(68, 112, 255); // Ganti dengan warna yang Anda inginkan

        // Gunakan GradientPaint untuk menggambar gradasi dari atas ke bawah
        GradientPaint gradient = new GradientPaint(0, 0, colorAtas, 0, getHeight(), colorBawah);
        g2d.setPaint(gradient);
        g2d.fillRect(0, 0, getWidth(), getHeight());
    }
}
    
    public class CustomButton extends JButton {

    private static final Color NORMAL_COLOR = Color.WHITE;
    private static final Color PRESSED_COLOR = Color.LIGHT_GRAY;
    private static final Color SHADOW_COLOR = new Color(0, 0, 0, 76); // Warna bayangan dengan opasitas 30%

    public CustomButton(String label) {
        super(label);
        setFocusPainted(false);
        setBorderPainted(false); // Tidak menggambar border
        setContentAreaFilled(false); // Tidak menggambar area isi
        setOpaque(false);
        setFont(new Font("Lato", Font.BOLD, 18));
        setBackground(Color.WHITE);
        setForeground(Color.BLACK);

        setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        // Menambahkan pemantauan mouse
        addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) {
                setBackground(PRESSED_COLOR);
                repaint();
            }

            public void mouseReleased(MouseEvent e) {
                setBackground(NORMAL_COLOR);
                repaint();
            }
        });
    }

    @Override
    protected void paintComponent(Graphics g) {
        Graphics2D g2d = (Graphics2D) g.create();

        // Mengatur rendering hints untuk mendapatkan gambar yang lebih halus
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);

        // Menggambar bayangan
        g2d.setColor(SHADOW_COLOR);
        g2d.fillRoundRect(6, 6, getWidth() - 12, getHeight() - 12, 20, 20);

        // Menggambar tombol
        if (getModel().isArmed()) {
            g2d.setColor(PRESSED_COLOR);
        } else {
            g2d.setColor(getBackground());
        }
        g2d.fillRoundRect(0, 0, getWidth() - 1, getHeight() - 1, 20, 20);

        super.paintComponent(g);

        g2d.dispose();
    }

    @Override
    protected void paintBorder(Graphics g) {
        // Tidak menggambar border
    }

    protected void paintFocus(Graphics g) {
        // Tidak menggambar fokus
    }
    }
    
    public Aplikasi() {
        initComponents();
        Color col = new Color (245,246,250);
        getContentPane().setBackground(col);
        JTableHeader defaultHeader = tabelData.getTableHeader();
        defaultHeader.setBackground(new Color(245, 246, 250));
        tampilkan_data_overview();
        
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jButton1 = new javax.swing.JButton();
        jButton2 = new javax.swing.JButton();
        jButton3 = new javax.swing.JButton();
        jButton4 = new javax.swing.JButton();
        jPanel2 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        tabelData = new javax.swing.JTable();
        jLabel1 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Ojek Online");
        setMaximumSize(new java.awt.Dimension(875, 600));
        setResizable(false);

        jLabel2.setFont(new java.awt.Font("Lato", 1, 18)); // NOI18N
        jLabel2.setForeground(new java.awt.Color(44, 53, 77));
        jLabel2.setText("Welcome,");

        jLabel3.setFont(new java.awt.Font("Lato", 1, 24)); // NOI18N
        jLabel3.setForeground(new java.awt.Color(44, 53, 77));
        jLabel3.setText("User Admin");

        javax.swing.JButton jButton1 = new CustomButton("Overview\nDatabase");
        jButton1.setFont(new java.awt.Font("Lato", 1, 18)); // NOI18N
        jButton1.setForeground(new java.awt.Color(44, 53, 77));
        jButton1.setIcon(new FlatSVGIcon("Icons/Overview.svg", 40,40));
        jButton1.setText("<html><center>Overview<br>Database</center></html>");
        jButton1.setBorder(javax.swing.BorderFactory.createEmptyBorder(1, 1, 1, 1));
        jButton1.setBorderPainted(false);
        jButton1.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        javax.swing.JButton jButton2 = new CustomButton("List\nBooking");
        jButton2.setFont(new java.awt.Font("Lato", 1, 18)); // NOI18N
        jButton2.setForeground(new java.awt.Color(44, 53, 77));
        jButton2.setIcon(new FlatSVGIcon("Icons/Ticket.svg", 40,40));
        jButton2.setText("<html><left>List<br>Booking</left></html>");
        jButton2.setBorder(javax.swing.BorderFactory.createEmptyBorder(1, 1, 1, 1));
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        javax.swing.JButton jButton3 = new CustomButton("List\nDriver   ");
        jButton3.setFont(new java.awt.Font("Lato", 1, 18)); // NOI18N
        jButton3.setForeground(new java.awt.Color(44, 53, 77));
        jButton3.setIcon(new FlatSVGIcon("Icons/Car.svg", 43,40));
        jButton3.setText("<html><left>List<br> Driver   </left></html>");
        jButton3.setAlignmentY(0.0F);
        jButton3.setBorder(javax.swing.BorderFactory.createEmptyBorder(1, 1, 1, 1));
        jButton3.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        jButton3.setIconTextGap(2);
        jButton3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton3ActionPerformed(evt);
            }
        });

        javax.swing.JButton jButton4 = new CustomButton("List\nPassenger");
        jButton4.setFont(new java.awt.Font("Lato", 1, 18)); // NOI18N
        jButton4.setForeground(new java.awt.Color(44, 53, 77));
        jButton4.setIcon(new FlatSVGIcon("Icons/People.svg", 40,40));
        jButton4.setText("<html><left>List<br>Passenger</left></html>");
        jButton4.setBorder(javax.swing.BorderFactory.createEmptyBorder(1, 1, 1, 1));
        jButton4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton4ActionPerformed(evt);
            }
        });

        jPanel2.setBackground(new java.awt.Color(255, 255, 255));

        tabelData.setBorder(javax.swing.BorderFactory.createEmptyBorder(1, 1, 1, 1));
        tabelData.setFont(new java.awt.Font("Lato", 0, 12)); // NOI18N
        tabelData.setForeground(new java.awt.Color(44, 53, 77));
        tabelData.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        tabelData.setGridColor(new java.awt.Color(51, 51, 51));
        jScrollPane1.setViewportView(tabelData);

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 601, Short.MAX_VALUE)
                .addContainerGap())
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                .addContainerGap())
        );

        jLabel1.setIcon(new FlatSVGIcon("Icons/Home.svg", 879,202));
        jLabel1.setMaximumSize(new java.awt.Dimension(353, 81));
        jLabel1.setMinimumSize(new java.awt.Dimension(353, 81));
        jLabel1.setPreferredSize(new java.awt.Dimension(353, 81));

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(51, 51, 51)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jButton4, javax.swing.GroupLayout.DEFAULT_SIZE, 148, Short.MAX_VALUE)
                    .addComponent(jButton2, javax.swing.GroupLayout.DEFAULT_SIZE, 148, Short.MAX_VALUE)
                    .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 126, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel3)
                    .addComponent(jButton1, javax.swing.GroupLayout.DEFAULT_SIZE, 148, Short.MAX_VALUE)
                    .addComponent(jButton3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(55, Short.MAX_VALUE))
            .addComponent(jLabel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 142, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel2)
                        .addGap(6, 6, 6)
                        .addComponent(jLabel3)
                        .addGap(23, 23, 23)
                        .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 78, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jButton2, javax.swing.GroupLayout.PREFERRED_SIZE, 78, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 78, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jButton4, javax.swing.GroupLayout.PREFERRED_SIZE, 78, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap(45, Short.MAX_VALUE))
        );

        pack();
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        // TODO add your handling code here:
        tampilkan_data_overview();
    }//GEN-LAST:event_jButton1ActionPerformed

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        // TODO add your handling code here:
        tampilkan_data_booking();
    }//GEN-LAST:event_jButton2ActionPerformed

    private void jButton3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton3ActionPerformed
        // TODO add your handling code here:
        tampilkan_data_driver();
    }//GEN-LAST:event_jButton3ActionPerformed

    private void jButton4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton4ActionPerformed
        // TODO add your handling code here:
        tampilkan_data_passenger();
    }//GEN-LAST:event_jButton4ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Aplikasi.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Aplikasi.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Aplikasi.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Aplikasi.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Aplikasi().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JButton jButton3;
    private javax.swing.JButton jButton4;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable tabelData;
    // End of variables declaration//GEN-END:variables
}
