From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar spi1 and spi2
Date: Thu, 30 Jul 2015 09:10:55 +0200
Message-ID: <97861F80-CF83-4FF2-B96E-CDFB1A8F4921@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <55A0A150.3060809@wwwdotorg.org> <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org> <55A49662.3000706@wwwdotorg.org> <2768BFA9-7FE9-4EDC-8692-AC3F070BD874@martin.sperl.org> <55AEF828.20908@wwwdotorg.org> <0125992E-40F4-4702-8404-2943FF9A8788@martin.sperl.org> <55B1BA7A.1090104@wwwdotorg.org> <9005ABEC-C60A-4814-AD60-AD5BB09808F2@martin.sperl.org> <55B6EE1A.2070605@wwwdotorg.org> <836DA157-3072-441A-A160-E1FDBB119E88@martin.sperl.org> <55B75E07.1080104@martin.sperl.org> <55B9014C.7020105@lategoodbye.de> <C767C9AD-A9B5-428F-A207-D67269B380C6@martin.sperl.org> <55B9B7EF.2070108@lategoodbye.de> <C2C16277-C6C1-4F86-BB88-580CF667EF24@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C2C16277-C6C1-4F86-BB88-580CF667EF24-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi Stefan!

> On 30.07.2015, at 08:45, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote=
:
>=20
> I am just trying to find a solution that will get accepted with the m=
inimum
> number of reposts/rewrites to avoid frustration, but nobody has an an=
swer
> which api we really should use.
>=20
> The problem is that we have DT and we have code and as we only want H=
W
> being represented in the device tree we need something =E2=80=9Csensi=
ble=E2=80=9D.
>=20
> What about adding =E2=80=9Cbcrm,bcm2835-aux-enable=E2=80=9D to driver=
s/mfd/syscon.c
> compatibility?
>=20
> That way we:
> * have a clean dt that only represents hardware
> * reuse existing code with minimal modifications
> * minimal effort
>=20
> That would be a minimal patch to enable this, so we can ask if that i=
s
> acceptable and if it is not then we can still think of something else=
,
> which would be mostly replicating the bit-management portion of sysco=
n.

that minimal patch extending compatibility of syscon and also including
the config portion for the kernel as well as the device tree would look
something like this (note that it is not tested yet):

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835=
=2Edtsi
index 301c73f..bde42ce 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -158,6 +158,11 @@
                arm-pmu {
                        compatible =3D "arm,arm1176-pmu";
                };
+
+               aux-enable: aux-enable@0x7e215004 {
+                       compatible =3D "bcrm,bcm2835-aux-enable";
+                       reg =3D <0x7e215004 0x04>;
+               };
        };

        clocks {
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 0ac9e4b3..e32ceea 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -116,6 +116,7 @@ config ARCH_BCM2835
        select CLKSRC_OF
        select PINCTRL
        select PINCTRL_BCM2835
+       select MFD_SYSCON
        help
          This enables support for the Broadcom BCM2835 SoC. This SoC i=
s
          used in the Raspberry Pi and Roku 2 devices.
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 176bf0f..49cdd37 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -211,6 +211,12 @@ static int syscon_probe(struct platform_device *pd=
ev)
        return 0;
 }

+static const struct of_device_id syscon_match[] =3D {
+       { .compatible =3D "bcrm,bcm2835-aux-enable", },
+       {}
+};
+MODULE_DEVICE_TABLE(of, syscon_match);
+
 static const struct platform_device_id syscon_ids[] =3D {
        { "syscon", },
        { }
@@ -219,6 +225,7 @@ static const struct platform_device_id syscon_ids[]=
 =3D {
 static struct platform_driver syscon_driver =3D {
        .driver =3D {
                .name =3D "syscon",
+               .of_match_table =3D syscon_match,
        },
        .probe          =3D syscon_probe,
        .id_table       =3D syscon_ids,

(please ignore the tabs converted to spaces for now introduced by copy/=
paste)

Then what would be missing is the config of the spi/uart devices
that would require a property in the device-tree like:
	bcrm,aux-enable =3D <&aux-enable 1 /* bitmask for device */>;

which then would be used by the respective drivers like this:
enable:
  regmap_update_bits(bs->aux_enable, 0,
		     bs->aux_enable_mask, bs->aux_enable_mask);
disable:
  regmap_update_bits(bs->aux_enable, 0,
		     bs->aux_enable_mask, 0);

Is this something that you would accept?

Thanks,
	Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
