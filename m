From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 17:19:07 +0530
Message-ID: <525D2BB3.4020705@ti.com>
References: <52566ACC.1080100@ti.com> <20131010101410.GG21581@sirena.org.uk>
 <52568AA3.9080203@ti.com> <20131011100839.GA21581@sirena.org.uk>
 <525CDB77.4040201@ti.com> <20131015111647.GX2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <peter@korsgaard.com>, Trent Piepho <tpiepho@gmail.com>,
 balbi@ti.com, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131015111647.GX2443@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,
On Tuesday 15 October 2013 04:46 PM, Mark Brown wrote:
> On Tue, Oct 15, 2013 at 11:36:47AM +0530, Sourav Poddar wrote:
>
>> But there is one problem which I faced while trying to achieve the
>> above. Currently, spi
>> framework takes care of the runtime clock control part in
>> pump_message(spi.c). So, at the
>> beginning of each transfer, there is a "get_sync" while at the end
>> there is a "put_sync". Now, if
>> I try to do a memcpy in flash and bypass the SPI framework, there is
>> a data abort as the SPI
>> controller clocks are cut.
> Can you fix this by enabling the clock is enabled when you return the
> buffer to the MTD layer and then disabling the clock when the buffer is
> released?
Sorry, I did not get you here. With memory mapped read, there is no
buffer exchanged, everything takes place at the mtd layer only, what gets
exchanged is just the memory mapped address.

Here is the patch which I did on top of the subject patch series, wherein my
controller is in default memory mapped mode, while doing a read in mtd layer
its just does a memcopy and return.

This gives me a data abort as pm_runtime_get_sync is not called on the 
qspi controller.


Index: linux/drivers/mtd/devices/m25p80.c
===================================================================
--- linux.orig/drivers/mtd/devices/m25p80.c    2013-10-15 
17:08:15.000000000 +0530
+++ linux/drivers/mtd/devices/m25p80.c    2013-10-15 17:08:26.000000000 
+0530
@@ -102,7 +102,7 @@
      u8            *command;
      bool            fast_read;
      bool            quad_read;
-    bool            mmap_read;
+    void            *mmap_read;
  };

  static inline struct m25p *mtd_to_m25p(struct mtd_info *mtd)
@@ -438,18 +438,21 @@
      pr_debug("%s: %s from 0x%08x, len %zd\n", dev_name(&flash->spi->dev),
              __func__, (u32)from, len);
      printk("enter mtd quad..\n");
+
+    if (flash->mmap_read) {
+        printk("memory map=%x\n", flash->mmap_read);
+        memcpy(buf, flash->mmap_read + from, len);
+        *retlen = len;
+        return 0;
+    }
+
      spi_message_init(&m);
      memset(t, 0, (sizeof(t)));

-    if (flash->mmap_read)
-        t[0].memory_map = 1;
      t[0].tx_buf = flash->command;
-    t[0].len = flash->mmap_read ? from : (m25p_cmdsz(flash) + 
(flash->quad_read ? 1 : 0));
-    printk("t[0].len=%d\n", t[0].len);
+    t[0].len = (m25p_cmdsz(flash) + (flash->quad_read ? 1 : 0));
      spi_message_add_tail(&t[0], &m);

-        if (flash->mmap_read)
-        t[1].memory_map = 1;
      t[1].rx_buf = buf;
      t[1].len = len;
      t[1].rx_nbits = SPI_NBITS_QUAD;
@@ -476,7 +479,7 @@

      spi_sync(flash->spi, &m);

-    *retlen = flash->mmap_read ? len : (m.actual_length - 
m25p_cmdsz(flash) -
+    *retlen = (m.actual_length - m25p_cmdsz(flash) -
              (flash->quad_read ? 1 : 0));

      mutex_unlock(&flash->lock);
@@ -1215,7 +1218,7 @@

      if (spi->mode && SPI_RX_MMAP) {
          printk("memory mapped mode set\n");
-        flash->mmap_read = true;
+        flash->mmap_read = spi->memory_map;
      }
      flash->command = kmalloc(MAX_CMD_SIZE + (flash->fast_read ? 1 :
                  (flash->quad_read ? 1 : 0)), GFP_KERNEL);
Index: linux/drivers/spi/spi-ti-qspi.c
===================================================================
--- linux.orig/drivers/spi/spi-ti-qspi.c    2013-10-15 
17:08:15.000000000 +0530
+++ linux/drivers/spi/spi-ti-qspi.c    2013-10-15 17:15:52.000000000 +0530
@@ -256,6 +256,8 @@
              break;
          }
          ti_qspi_write(qspi, memval, QSPI_SPI_SETUP0_REG);
+        enable_qspi_memory_mapped(qspi);
+        spi->memory_map = qspi->mmap_base;
          spi->mode |= SPI_RX_MMAP;
      }

@@ -433,22 +435,13 @@
      qspi->cmd |= QSPI_FLEN(frame_length);
      qspi->cmd |= QSPI_WC_CMD_INT_EN;

+    disable_qspi_memory_mapped(qspi);
+
      ti_qspi_write(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);

      mutex_lock(&qspi->list_lock);

      list_for_each_entry(t, &m->transfers, transfer_list) {
-               if (t->memory_map) {
-                       if (t->tx_buf) {
-                               from = t->len;
-                               continue;
-                       }
-                       enable_qspi_memory_mapped(qspi);
-                       memcpy(t->rx_buf, qspi->mmap_base + from, t->len);
-                       disable_qspi_memory_mapped(qspi);
-                       goto out;
-               }
-
          qspi->cmd |= QSPI_WLEN(t->bits_per_word);

          ret = qspi_transfer_msg(qspi, t);
@@ -461,13 +454,13 @@
          m->actual_length += t->len;
      }

-out:
      mutex_unlock(&qspi->list_lock);

      m->status = status;
      spi_finalize_current_message(master);

      ti_qspi_write(qspi, qspi->cmd | QSPI_INVAL, QSPI_SPI_CMD_REG);
+    enable_qspi_memory_mapped(qspi);

      return status;
  }
@@ -599,6 +592,7 @@
      if (res_mmap) {
          printk("mmap_available\n");
          qspi->mmap_base = devm_ioremap_resource(&pdev->dev, res_mmap);
+        printk("qspi->mmap_base=%x\n", qspi->mmap_base);
          if (IS_ERR(qspi->mmap_base)) {
              ret = PTR_ERR(qspi->mmap_base);
              goto free_master;
Index: linux/include/linux/spi/spi.h
===================================================================
--- linux.orig/include/linux/spi/spi.h    2013-10-15 17:08:15.000000000 
+0530
+++ linux/include/linux/spi/spi.h    2013-10-15 17:08:26.000000000 +0530
@@ -94,6 +94,7 @@
  #define SPI_RX_MMAP    0x1000            /* Memory mapped read */
      u8            bits_per_word;
      int            irq;
+     void __iomem        *memory_map;
      void            *controller_state;
      void            *controller_data;
      char            modalias[SPI_NAME_SIZE];
@@ -556,7 +557,6 @@
      u16        delay_usecs;
      u32        speed_hz;

-    bool    memory_map;
      struct list_head transfer_list;
  };



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
