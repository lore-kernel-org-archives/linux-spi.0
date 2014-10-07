From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
Date: Mon, 6 Oct 2014 19:19:44 -0500
Message-ID: <1412641184.13320.506.camel@snotra.buserror.net>
References: <20141003125609.5BEA11AB276@localhost.localdomain>
	 <20141003144420.GC24441@sirena.org.uk> <542F03CF.8010900@c-s.fr>
	 <1412367858.13320.432.camel@snotra.buserror.net> <542FC8C1.1000707@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	"Marcelo Tosatti" <marcelo@kvack.org>,
	Vitaly Bordug <vitb@kernel.crashing.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>,
	Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: christophe leroy <christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <542FC8C1.1000707@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, 2014-10-04 at 12:15 +0200, christophe leroy wrote:
> Le 03/10/2014 22:24, Scott Wood a =C3=A9crit :
> > On Fri, 2014-10-03 at 22:15 +0200, christophe leroy wrote:
> >> Le 03/10/2014 16:44, Mark Brown a =C3=A9crit :
> >>> On Fri, Oct 03, 2014 at 02:56:09PM +0200, Christophe Leroy wrote:
> >>>
> >>>> +config CPM1_RELOCSPI
> >>>> +	bool "Dynamic SPI relocation"
> >>>> +	default n
> >>>> +	help
> >>>> +	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be rel=
ocated
> >>>> +	  without micropatch. This activates relocation to a dynamical=
ly
> >>>> +	  allocated area in the CPM Dual port RAM.
> >>>> +	  When combined with SPI relocation patch (for older MPC8xx) i=
t avoids
> >>>> +	  the "loss" of additional Dual port RAM space just above the =
patch,
> >>>> +	  which might be needed for example when using the CPM QMC.
> >>> Something like this shouldn't be a compile time option.  Either i=
t
> >>> should be unconditional or it should be triggered in some system
> >>> specific manner (from DT, from knowing about other users or simil=
ar).
> >> Can't be unconditional as older versions of mpc8xx (eg MPC860) don=
't
> >> support relocation without a micropatch.
> >> I have therefore submitted a v2 based on a DTS compatible property=
=2E
> > So the device tree change is about whether relocation is supported,=
 not
> > whether it is required?
> Indeed no, my intension is to say that relocation is requested. Do yo=
u=20
> mean that it should then not use a compatible ?

The device tree describes hardware.  It doesn't tell software how to us=
e
that hardware.

Based on one of your other e-mails, I think what you want to say here i=
s
that the old binding didn't describe the registers needed for
relocation, so the new compatible describes the new binding, rather tha=
n
requesting that software do a relocation.  Software that sees the new
binding could choose to relocate, or just choose to read the current
offset from the register.

> > How about checking for the existing specific-SoC compatibles?
> What do you mean ?

Look for "fsl,mpc885-cpm-i2c" etc.  Or, if you didn't follow that
pattern (remember, I can't see your device tree!), look for
"fsl,mpc885-cpm" or "fsl,mpc866-cpm" in the parent node.  It's moot
though, if the device tree also needs to be modified to describe the
register used to relocate.

-Scott
