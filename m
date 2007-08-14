From: llandre <r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
Subject: Re: R: spi_async and heavy CPU occupation by
 ksoftirqd
Date: Tue, 14 Aug 2007 11:43:21 +0200
Message-ID: <46C17939.1010204@dave-tech.it>
References: <FLEPLOLKEPNLMHOILNHPIEKIDKAA.a.paterniani@swapp-eng.it>
	<46C167F0.4040100@dave-tech.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030104000308060702040803"
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46C167F0.4040100-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--------------030104000308060702040803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Atatched is a dirty ugly patch that seems to work for 1-byte transfers I 
use with QT510.
In case RDY control is enabled, transfer is completed by

interrupt_data_ready (new irq handler)
pump_transfers (tasklet)

in this order.


Regards,
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave-tech.it
email: r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org


> AFAIK introducing support for RDY in the driver is not a trivial matter.
> Since
> a) I just need to perform 1-byte transactions to communicate with 
> Quantum QT510
> b) I don't have much time to spend on this issue (customer needs to 
> assemble a demo quickly)
> I'm afraid I'll have to write a dirty patch just to make my specific 
> configuration work.
> 
> I'll keep you informed anyway.
> 
> Regards,
> llandre
> 
> DAVE Electronics System House - R&D Department
> web:   http://www.dave-tech.it
> email: r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org
> 
> 
> 
>> You're right the current version of the driver doesn't support RDY control.
>> Infact SPI_DEFAULT_CONTROL is defined with SPI_CONTROL_DRCTL_0.
>> Also setup function doesn't managed DRCTL changes.
>>
>> Then you probably changes SPI_DEFAULT_CONTROL to use SPI_CONTROL_DRCTL_2.
>>
>> Please do your suggestions for driver modification in order to release a driver patch.
>>
>> - Andrea
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> 
> 


--------------030104000308060702040803
Content-Type: text/plain;
 name="spi-imx-rdy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spi-imx-rdy.patch"

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 25c22ff..2b9ab9c 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -148,6 +148,7 @@
 #define SPI_DEFAULT_ENABLE_LOOPBACK	(0)
 #define SPI_DEFAULT_ENABLE_DMA		(0)
 #define SPI_DEFAULT_PERIOD_WAIT		(8)
+#define SPI_IS_RDY_ENABLED			((SPI_DEFAULT_CONTROL & SPI_CONTROL_DRCTL_2) ? 1 : 0)
 /*-------------------------------------------------------------------------*/
 
 
@@ -281,7 +282,7 @@ static int flush(struct driver_data *drv_data)
 		while (readl(regs + SPI_INT_STATUS) & SPI_STATUS_RR)
 			d = readl(regs + SPI_RXDATA);
 	} while ((readl(regs + SPI_CONTROL) & SPI_CONTROL_XCH) && limit--);
-
+	
 	return limit;
 }
 
@@ -754,6 +755,20 @@ static irqreturn_t interrupt_wronly_transfer(struct driver_data *drv_data)
 	return handled;
 }
 
+static irqreturn_t interrupt_data_ready(struct driver_data *drv_data){
+	void __iomem *regs = drv_data->regs;
+
+	/* Read rx data */
+	read(drv_data);
+	/* Disable irq */
+	writel(readl(regs + SPI_INT_STATUS) & ~SPI_INTEN,
+		regs + SPI_INT_STATUS);
+	/* Schedule transfer tasklet */
+	tasklet_schedule(&drv_data->pump_transfers);
+	
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 {
 	struct spi_message *msg = drv_data->cur_msg;
@@ -763,7 +778,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 	unsigned long limit;
 
 	status = readl(regs + SPI_INT_STATUS);
-
+	
 	while (status & (SPI_STATUS_TH | SPI_STATUS_RO)) {
 		dev_dbg(&drv_data->pdev->dev,
 			"interrupt_transfer - status = 0x%08X\n", status);
@@ -785,23 +800,30 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 
 			msg->state = ERROR_STATE;
 			tasklet_schedule(&drv_data->pump_transfers);
-
+			
 			return IRQ_HANDLED;
 		}
 
 		/* Pump data */
 		read(drv_data);
 		if (write(drv_data)) {
-			writel(readl(regs + SPI_INT_STATUS) & ~SPI_INTEN,
-				regs + SPI_INT_STATUS);
+			if (SPI_IS_RDY_ENABLED) {
+				/* RX IRQ handler will complete the transfer */
+				drv_data->transfer_handler = interrupt_data_ready;
+				writel((readl(regs + SPI_INT_STATUS) & ~SPI_INTEN) | SPI_INTEN_RE,
+					regs + SPI_INT_STATUS);
+				goto skip_rx_poll;
+			} else {
+				writel(readl(regs + SPI_INT_STATUS) & ~SPI_INTEN,
+					regs + SPI_INT_STATUS);
+			}
 
 			dev_dbg(&drv_data->pdev->dev,
 				"interrupt_transfer - end of tx\n");
-
+			
 			/* Read trailing bytes */
 			limit = loops_per_jiffy << 1;
 			while ((read(drv_data) == 0) && limit--);
-
 			if (limit == 0)
 				dev_err(&drv_data->pdev->dev,
 					"interrupt_transfer - "
@@ -810,6 +832,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 				dev_dbg(&drv_data->pdev->dev,
 					"interrupt_transfer - end of rx\n");
 
+skip_rx_poll:
 			/* End of transfer, update total byte transfered */
 			msg->actual_length += drv_data->len;
 
@@ -821,9 +844,11 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 			/* Move to next transfer */
 			msg->state = next_transfer(drv_data);
 
-			/* Schedule transfer tasklet */
-			tasklet_schedule(&drv_data->pump_transfers);
-
+			if (!SPI_IS_RDY_ENABLED) {
+				/* Schedule transfer tasklet */
+				tasklet_schedule(&drv_data->pump_transfers);
+			}
+			
 			return IRQ_HANDLED;
 		}
 
@@ -832,7 +857,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 		/* We did something */
 		handled = IRQ_HANDLED;
 	}
-
+	
 	return handled;
 }
 
@@ -949,7 +974,7 @@ static void pump_transfers(unsigned long data)
 
 	/* Assert device chip-select */
 	drv_data->cs_control(SPI_CS_ASSERT);
-
+	
 	/* DMA cannot read/write SPI FIFOs other than 16 bits at a time; hence
 	   if bits_per_word is less or equal 8 PIO transfers are performed.
 	   Moreover DMA is convinient for transfer length bigger than FIFOs
@@ -1089,7 +1114,7 @@ static void pump_messages(struct work_struct *work)
 	/* Setup the SPI using the per chip configuration */
 	drv_data->cur_chip = spi_get_ctldata(drv_data->cur_msg->spi);
 	restore_state(drv_data);
-
+	
 	/* Mark as busy and launch transfers */
 	tasklet_schedule(&drv_data->pump_transfers);
 }

--------------030104000308060702040803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--------------030104000308060702040803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--------------030104000308060702040803--
