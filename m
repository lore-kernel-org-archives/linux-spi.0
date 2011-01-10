From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: RE: [PATCH] mtd: sst25l: fix reads with broken spi-masters
Date: Mon, 10 Jan 2011 16:36:50 -0600
Message-ID: <0D753D10438DA54287A00B027084269764CDF41635__5958.4035109312$1294700709$gmane$org@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B027084269764CDF4146A@AUSP01VMBX24.collaborationhost.net>
	<909411.87280.qm@web180312.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Artem.Bityutskiy-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <Artem.Bityutskiy-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "spi-devel-general
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <909411.87280.qm-4JhmkcZgSkmZZBmlwP4mLPu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday, January 10, 2011 3:20 PM, David Brownell wrote:
> --- On Mon, 1/10/11, H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:
> NAK.  I'm surprised you even thought to submit
> such a clearly-wrong patch.
>
> The bug is in the SPI master driver, and thus
> so should the fix be.  Or make your system use
> the GPIO based SPI master driver.

Sorry.

The bug _is_ in the spi peripheral on the ep93xx.

Unfortunately, hardware does exist that uses the SFRMOUT signal as part of
the chip select to access the device.  The only way to get this signal to
do anything is by using the spi peripheral.  The SFRMOUT signal cannot be
accessed using GPIO so the GPIO based SPI master driver is not an option.

If the SFRMOUT signal is _not_ used in the chip select logic then everything
works fine.

But... If it's a NAK.. It's a NAK...  I'll try to figure out a way to handle
this in the SPI master driver.

Regards,
Hartley




------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
