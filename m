From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Protocol driver probe function never invoked
Date: Tue, 24 Jul 2007 06:28:14 -0700
Message-ID: <200707240628.14536.david-b@pacbell.net>
References: <46A46CCA.7010303@dave-tech.it> <46A59E7A.8010204@dave-tech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46A59E7A.8010204-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
Content-Disposition: inline
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

On Monday 23 July 2007, llandre wrote:
> The probe function is not invoked because the controller does not allow 
> to reach the max_speed_hz.
> I did not realize this before because, even if the debug messages were 
> enabled, I did not see any warning message about this.

I want to be sure I understand this correctly.  You're saying that
the call to spi_setup() inside of spi_new_device() failed silently?
And thus the scan_boardinfo() failed?

If so, I'm thinking the following patch would help ... right?

--- g26.orig/drivers/spi/spi.c	2007-07-24 06:27:04.000000000 -0700
+++ g26/drivers/spi/spi.c	2007-07-24 06:26:39.000000000 -0700
@@ -325,9 +325,17 @@ static void scan_boardinfo(struct spi_ma
 		unsigned		n;
 
 		for (n = bi->n_board_info; n > 0; n--, chip++) {
+			int	status;
+
 			if (chip->bus_num != master->bus_num)
 				continue;
-			(void) spi_new_device(master, chip);
+			status = spi_new_device(master, chip);
+			if (status < 0)
+				dev_err(master->cdev.dev,
+					"can't create spi_device, err %d; "
+					"chipselect %d, modalias %s\n",
+					status, chip->chip_select,
+					chip->modalias);
 		}
 	}
 	mutex_unlock(&board_lock);




-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
