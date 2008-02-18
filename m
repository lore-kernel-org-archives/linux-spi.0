From: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: atmel_spi clock polarity
Date: Mon, 18 Feb 2008 12:42:37 +0100
Message-ID: <20080218124237.0b5f701c@dhcp-252-066.norway.atmel.com>
References: <20080216.223252.25909396.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080216.223252.25909396.anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
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

On Sat, 16 Feb 2008 22:32:52 +0900 (JST)
Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org> wrote:

> Here is my quick workaround for this problem.  It makes all CSRn.CPOL
> match for the transfer before activating chipselect.  I'm not quite
> sure my analysis is correct, and there might be better solution.
> Could you give me any comments?

I'm not sure if I fully understand what problem you're seeing. Is the
clock state wrong when the chip select is activated? If so, does the
patch below help?

Haavard

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 293b7ca..4f19b82 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -90,6 +90,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 	mr = spi_readl(as, MR);
 	mr = SPI_BFINS(PCS, ~(1 << spi->chip_select), mr);
+	spi_writel(as, MR, mr);
 
 	dev_dbg(&spi->dev, "activate %u%s, mr %08x\n",
 			gpio, active ? " (high)" : "",
@@ -97,7 +98,6 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 	if (!(cpu_is_at91rm9200() && spi->chip_select == 0))
 		gpio_set_value(gpio, active);
-	spi_writel(as, MR, mr);
 }
 
 static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
