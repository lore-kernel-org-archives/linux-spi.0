From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: [PATCH] TXx9 SPI controller driver
Date: Sun, 24 Jun 2007 00:41:59 +0900 (JST)
Message-ID: <20070624.004159.07644824.anemo@mba.ocn.ne.jp>
References: <20070622.232111.36926005.anemo@mba.ocn.ne.jp>
	<200706221103.19761.david-b@pacbell.net>
	<200706221151.24959.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	mlachwani-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706221151.24959.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Fri, 22 Jun 2007 11:51:24 -0700, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > > This is a driver for SPI controller built into TXx9 MIPS SoCs.
> > 
> > Looks mostly pretty good.  I made a few minor changes/cleanups
> > in the appended version, notably:
> >  - checking for spi->mode bits this code doesn't understand;
> >  - updating to match latest patches;
> > 
> > Note that if gpio_set_value() needs an mmiowb(), that seems like
> > a bug in this platform's  GPIO code; other platforms don't require
> > I/O barriers after GPIO calls.  Comments?
> > 
> > Also:
> > 
> 
> ... yeah, -ENOPATCH, sorry.  And the minor whitespace fixes.
> 
> One more comment:  surely platform_driver_probe() would be
> appropriate here?

Thank you for excellent review!  I'll look at each comments surely
will update the driver but it may take a few days.

For now, I'm quite sure your patch is OK for me except for one thing:

> + * spi_tx99.c - TXx9 SPI controller driver.

Name it spi_txx9.c, please ;)

And for mmiowb() issue, I put it just only I was not sure whether
gpio_set_value() guarantee I/O barrier.  Now I see i2c-gpio.c, etc. do
not have such barriers.  I will remove these barriers and fix platform
gpio codes.

---
Atsushi Nemoto

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
