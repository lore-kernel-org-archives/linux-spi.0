From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: [PATCH] TXx9 SPI controller driver (take 2)
Date: Sun, 01 Jul 2007 02:34:14 +0900 (JST)
Message-ID: <20070701.023414.71085498.anemo@mba.ocn.ne.jp>
References: <20070627.222458.27955527.anemo@mba.ocn.ne.jp>
	<200706300953.20156.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	mlachwani-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706300953.20156.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Sat, 30 Jun 2007 09:53:19 -0700, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > This is a driver for SPI controller built into TXx9 MIPS SoCs.
> > This driver is derived from arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c.
> > 
> > Signed-off-by: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
> > ---
> > Changes from previous version:
> 
> Better, but still not there yet.

Thanks!  I'll be back with take 3 patch.

> > +	txx9spi_cs_func(spi, c, 0, 1000000000 / 2 / spi->max_speed_hz);
> 
> You still use this confusing A/2/B syntax.  Please
> rewrite that using one "/" and one "*".  (And there
> is similar usage elsewhere.)

The compiler will optimize "1000000000 / 2 / spi->max_speed_hz" into
"500000000 / spi->max_speed_hz", so it can be treat as one "/", no?

---
Atsushi Nemoto

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
