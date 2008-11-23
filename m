From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 05/14] mfd: PCAP2 driver
Date: Sat, 22 Nov 2008 18:19:52 -0800
Message-ID: <200811221819.53186.david-b@pacbell.net>
References: <20081121160403.073751031@dodger.lab.datenfreihafen.org>
	<200811221558.03915.david-b@pacbell.net>
	<20081123003306.GE24437@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Stefan Schmidt <stefan-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Stefan Schmidt <stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20081123003306.GE24437-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Saturday 22 November 2008, Stefan Schmidt wrote:
> > =

> > Looks to me like you're almost all the way there already! =A0:)
> =

> We hope so, yes. :) Once we have the EZX/PXA dep gone you are fine with t=
his
> patch? All SPI related stuff is ok from you?

SPI-specific bits:

 - I'd have to see the patch.  The last one I saw still didn't
   list a SPI_MASTER dependency for the core MFD module.

 - You should make ezx_pcap_write() and ezx_pcap_read() switch
   over to spi_write_then_read(), to ensure it's never doing
   DMA to/from the stack.  I see a byte-order dependency too...

 - For general paranoia, the probe() should abort if pcap.spi is
   already set ... and its cleanup path, plus remove(), should
   null that pointer.

 - If you're going to mark the probe() as __devinit, then mark
   the remove() as __devexit and use __devexit_p() in the driver
   struct.

Other comments about the pcap2 core:

 - The set_vreg() stuff would seem to make more sense in a
   regulator subdevice and driver ... but that's more of a
   general driver structure thing, and might be fixed later.

 - Andrew seems to always want a comment explaining why the
   IRQ handler for I2C and SPI devices needs to queue_work().
   Maybe the threaded IRQ stuff will help there...

 - The mask_event()/unmask_event() stuff looks like you're
   more or less reinventing a baby "struct irq_chip", with
   register_event() instead of request_irq().

 - Those show_regs/store_regs calls would IMO make more sense
   in debugfs than in sysfs.

 - And the ADC sysfs support isn't supporting hwmon models.
   (Neither does the twl4030 ADC support, but that's not been
   submitted for mainline yet either...)

Re the IRQ stuff, this looks more like what i2c/chips/menelaus.c
did than mfd/twl4030-irq.c ... in general I think it's better to
pursue the latter approach, making genirq handle such stuff.
(Even though it's kind of awkward to use it for I2C or SPI based
interrupt controllers just now.)

- Dave

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
