From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
Date: Wed, 8 Oct 2014 13:45:21 -0500
Message-ID: <1412793921.13320.545.camel@snotra.buserror.net>
References: <20141003125609.5BEA11AB276@localhost.localdomain>
	 <20141003144420.GC24441@sirena.org.uk> <542F03CF.8010900@c-s.fr>
	 <1412367858.13320.432.camel@snotra.buserror.net> <542FC8C1.1000707@c-s.fr>
	 <1412641184.13320.506.camel@snotra.buserror.net> <54356A53.3010700@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	"Marcelo Tosatti" <marcelo-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>,
	Vitaly Bordug <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
To: leroy christophe <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54356A53.3010700-GgN8y9CXRhA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2014-10-08 at 18:46 +0200, leroy christophe wrote:
> Le 07/10/2014 02:19, Scott Wood a =C3=A9crit :
> > On Sat, 2014-10-04 at 12:15 +0200, christophe leroy wrote:
> >> Le 03/10/2014 22:24, Scott Wood a =C3=A9crit :
> >>> On Fri, 2014-10-03 at 22:15 +0200, christophe leroy wrote:
> >>>> Le 03/10/2014 16:44, Mark Brown a =C3=A9crit :
> >>>>> On Fri, Oct 03, 2014 at 02:56:09PM +0200, Christophe Leroy wrot=
e:
> >>>>>
> >>>>>> +config CPM1_RELOCSPI
> >>>>>> +	bool "Dynamic SPI relocation"
> >>>>>> +	default n
> >>>>>> +	help
> >>>>>> +	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be r=
elocated
> >>>>>> +	  without micropatch. This activates relocation to a dynamic=
ally
> >>>>>> +	  allocated area in the CPM Dual port RAM.
> >>>>>> +	  When combined with SPI relocation patch (for older MPC8xx)=
 it avoids
> >>>>>> +	  the "loss" of additional Dual port RAM space just above th=
e patch,
> >>>>>> +	  which might be needed for example when using the CPM QMC.
> >>>>> Something like this shouldn't be a compile time option.  Either=
 it
> >>>>> should be unconditional or it should be triggered in some syste=
m
> >>>>> specific manner (from DT, from knowing about other users or sim=
ilar).
> >>>> Can't be unconditional as older versions of mpc8xx (eg MPC860) d=
on't
> >>>> support relocation without a micropatch.
> >>>> I have therefore submitted a v2 based on a DTS compatible proper=
ty.
> >>> So the device tree change is about whether relocation is supporte=
d, not
> >>> whether it is required?
> >> Indeed no, my intension is to say that relocation is requested. Do=
 you
> >> mean that it should then not use a compatible ?
> > The device tree describes hardware.  It doesn't tell software how t=
o use
> > that hardware.
> >
> > Based on one of your other e-mails, I think what you want to say he=
re is
> > that the old binding didn't describe the registers needed for
> > relocation, so the new compatible describes the new binding, rather=
 than
> > requesting that software do a relocation.  Software that sees the n=
ew
> > binding could choose to relocate, or just choose to read the curren=
t
> > offset from the register.
> Not exactly.
> The old binding does describe the entire default param RAM (0x3d80 si=
ze=20
> 0x30). The relocation index is within this param RAM at 0x3dac.
> So the old binding is enough to allow relocation.

Oh, so the relocation register is part of the region?  If you relocate
the region, does the relocation register move, or stay at 0x3dac?  I
checked the manual and it wasn't clear.  I had assumed it worked the
same as cpm2, where the relocation register does not move.

> The issue today with the driver (hence my first patch) is that the=20
> driver reads the relocation index but takes a wrong decision if the=20
> index is 0: it assumes that an nul index means that a param RAM shall=
 be=20
> allocated, which is wrong. A nul index means that the component doesn=
't=20
> support relocation, so the default param RAM shall be used. The funct=
ion=20
> used for that is supposed to return the index. So when the index is=20
> null, I need to calculate it.
>=20
> Now, it can't be the SPI driver by itself that decide if he has to=20
> relocate or not. Because it depends whether I need to relocate or not=
=2E=20
> There is no point in waisting another area of the dualport RAM if I=20
> don't need to use SCC2 in a mode that overlaps the SPI parameter RAM.

Is the DPRAM currently fully utilized?

If it's really important to not waste 48 bytes of DPRAM, Could you make
the policy decision in platform code, or check at runtime what mode SCC=
2
is in?

> Today on the old MPC8xx, a microcode patch is needed in order to be a=
ble=20
> to relocate, and relocated address is directly fixed by the code=20
> handling the patch (sysdev/micropatch.c). The patch loading function =
is=20
> call very early in the boot process by cpm_reset() which is call by t=
he=20
> xxx_setup_arch().
> I have two issues with the way it is done today:
> 1/ the address which in hard coded is the micropatch loading function=
()=20
> is within the area for descripters for the QMC, so I would need to us=
e=20
> another address.
> 2/ for new MPC8xx which don't need microcode patch, I have no way tod=
ay=20
> to relocate.
>=20
> I have the same issue with the relocation of SMC1. Today when we=20
> activate SMC1 relocation microcode patch, the loading function has a=20
> hard coded relocation area for SMC1 which is the area dedicated to th=
e=20
> MPC8xx DSP. It means that I need to change it as I want to use the DS=
P.
>=20
> Would it be acceptable to define a fixed relocation address in the=20
> Kconfig in which we select microcode patch (arch/powerpc/platforms/8x=
x),=20
> instead of having it hardcoded in micropatch.c ?

No, that would prevent the ability to build support for all 8xx in one
kernel.

> Or maybe it would be possible to select which microcode patch we=20
> want/need via the device tree and which address shall be used for=20
> relocation ? What would you suggest to describe it ?

Yes, use the existing information in the device tree, or use PVR, to
determine which chip you're on and thus whic microcode to use.

> >
> >>> How about checking for the existing specific-SoC compatibles?
> >> What do you mean ?
> > Look for "fsl,mpc885-cpm-i2c" etc.  Or, if you didn't follow that
> > pattern (remember, I can't see your device tree!), look for
> > "fsl,mpc885-cpm" or "fsl,mpc866-cpm" in the parent node.  It's moot
> > though, if the device tree also needs to be modified to describe th=
e
> > register used to relocate.
> >
> > -Scott
> >
> I'm not sure I understood your question.
> My full device tree below
[snip]
>          cpm@9c0 {
>              #address-cells =3D <1>;
>              #size-cells =3D <1>;
>              compatible =3D "fsl,mpc885-cpm", "fsl,cpm1";
[snip]
>              spi: spi@a80 {
>                  #address-cells =3D <1>;
>                  #size-cells =3D <0>;
>                  cell-index =3D <0>;
>                  compatible =3D "fsl,spi", "fsl,cpm1-spi";

"fsl,cpm1-spi" should come first.

You didn't follow the pattern most CPM devices use, of
"fsl,mpc885-<device>", but you could look in the cpm node above to
determine that it's an mpc885.

-Scott


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
