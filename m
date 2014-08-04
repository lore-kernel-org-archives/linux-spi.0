From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: spi, spi_fsl-spi.c not working?
Date: Mon, 4 Aug 2014 16:52:56 -0500
Message-ID: <1407189176.10311.12.camel@snotra.buserror.net>
References: <53C79351.2080406@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Anton Vorontsov" <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
To: <hs-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53C79351.2080406-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2014-07-17 at 11:11 +0200, Heiko Schocher wrote:
> Hello all,
> 
> I just tried a mpc83xx based board (similiar to the mpc8313erdb)
> with linux v3.16-rc4 using the drivers/spi/spi-fsl-spi.c driver.
> DT nodes for spi are the same as in arch/powerpc/boot/dts/mpc8313erdb.dts:
> 
>                  spi@7000 {
>                          cell-index = <0>;
>                          compatible = "fsl,spi";
>                          reg = <0x7000 0x1000>;
>                          interrupts = <16 0x8>;
>                          interrupt-parent = <&ipic>;
>                          mode = "cpu";
>                  };
> 
> Bootlog shows:
> 
> [    1.341411] fsl_spi f0007000.spi: master is unqueued, this is deprecated
> [    1.554405] ------------[ cut here ]------------
> [    1.559080] WARNING: at c023a958 [verbose debug info unavailable]

If you haven't already resolved this, could you enable verbose debug
info (or use gdb) to get the line number?

I don't see the WARNING when booting mpc8379rdb with SPI enabled (though
I do see the "master is unqueued" message).  I don't have easy access to
an mpc8313erdb to test on.

-Scott


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
