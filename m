From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar
 spi1 and spi2
Date: Tue, 28 Jul 2015 12:48:39 +0200
Message-ID: <55B75E07.1080104@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <55A0A150.3060809@wwwdotorg.org> <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org> <55A49662.3000706@wwwdotorg.org> <2768BFA9-7FE9-4EDC-8692-AC3F070BD874@martin.sperl.org> <55AEF828.20908@wwwdotorg.org> <0125992E-40F4-4702-8404-2943FF9A8788@martin.sperl.org> <55B1BA7A.1090104@wwwdotorg.org> <9005ABEC-C60A-4814-AD60-AD5BB09808F2@martin.sperl.org> <55B6EE1A.2070605@wwwdotorg.org> <836DA157-3072-441A-A160-E1FDBB119E88@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <836DA157-3072-441A-A160-E1FDBB119E88-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 28.07.2015 08:18, Martin Sperl wrote:
> Hi Stephen!
> But the bigger question you have not answered is: =93where should suc=
h an
> auxiliar driver go in the kernel tree?=94 i.e. which directory?
One thing: could the "module" be a regulator?

So drivers/regulators/bcm2835-aux-regulator.c

The devicetree would look something like this:

regulators {
     bcm2835aux_reg {
         compatible =3D "bcrm,bcrm-2835-aux-enable";
         reg =3D <0x7e215004 0x4>; /* the AUX enable register */

         bcm2835aux_uart1: {
             regulator-name =3D "bcm2835_aux_uart1";
             reg =3D <0>; /* bit 0 in enable register */
         };
         bcm2835aux_spi1: {
             regulator-name =3D "bcm2835_aux_spi1";
             reg =3D <1>; /* bit 1 in enable register */
         };
         bcm2835aux_spi2: {
             regulator-name =3D "bcm2835_aux_spi2";
             reg =3D <2>; /* bit 2 in enable register */
         };
     }
};

uart1: uart1@7e215040 {
compatible =3D "brcm,bcm2835-aux-uart";
     reg =3D <0x7e215040 0x40>;
     ...
     vcc =3D <&bcm2835aux_uart1>
};

spi1: spi1@7e215080 {
compatible =3D "brcm,bcm2835-aux-spi";
     reg =3D <0x7e215080 0x40>;
     ...
     vcc =3D <&bcm2835aux_spi1>
};

spi2: spi2@7e2150C0 {
compatible =3D "brcm,bcm2835-aux-spi";
     reg =3D <0x7e2150C0 0x40>;
     ...
     vcc =3D <&bcm2835aux_spi2>
};

And the necessary driver-side code for bcm2835aux_spi and
bcm2835aux_uart would be along those lines:

probe:
   /* get the "power-supply" */
   bs->power =3D devm_regulator_get(dev, "vcc");
   if ((PTR_ERR(priv->power) =3D=3D -EPROBE_DEFER)
     return -EPROBE_DEFER
   /* enable the power-supply */
   regulator_enable(bs->power);

remove:
   regulator_disable(bs->power);

Would that look like an acceptable solution?

Thanks,
	Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
