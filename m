From: christophe leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1 parameter
 RAM
Date: Sat, 04 Oct 2014 12:15:29 +0200
Message-ID: <542FC8C1.1000707@c-s.fr>
References: <20141003125609.5BEA11AB276@localhost.localdomain>	 <20141003144420.GC24441@sirena.org.uk> <542F03CF.8010900@c-s.fr> <1412367858.13320.432.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	Marcelo Tosatti <marcelo-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>,
	Vitaly Bordug <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412367858.13320.432.camel-88ow+0ZRuxG2UiBs7uKeOtHuzzzSOjJt@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Le 03/10/2014 22:24, Scott Wood a =C3=A9crit :
> On Fri, 2014-10-03 at 22:15 +0200, christophe leroy wrote:
>> Le 03/10/2014 16:44, Mark Brown a =C3=A9crit :
>>> On Fri, Oct 03, 2014 at 02:56:09PM +0200, Christophe Leroy wrote:
>>>
>>>> +config CPM1_RELOCSPI
>>>> +	bool "Dynamic SPI relocation"
>>>> +	default n
>>>> +	help
>>>> +	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be reloc=
ated
>>>> +	  without micropatch. This activates relocation to a dynamically
>>>> +	  allocated area in the CPM Dual port RAM.
>>>> +	  When combined with SPI relocation patch (for older MPC8xx) it =
avoids
>>>> +	  the "loss" of additional Dual port RAM space just above the pa=
tch,
>>>> +	  which might be needed for example when using the CPM QMC.
>>> Something like this shouldn't be a compile time option.  Either it
>>> should be unconditional or it should be triggered in some system
>>> specific manner (from DT, from knowing about other users or similar=
).
>> Can't be unconditional as older versions of mpc8xx (eg MPC860) don't
>> support relocation without a micropatch.
>> I have therefore submitted a v2 based on a DTS compatible property.
> So the device tree change is about whether relocation is supported, n=
ot
> whether it is required?
Indeed no, my intension is to say that relocation is requested. Do you=20
mean that it should then not use a compatible ?
> Is this specific to SPI or does the relocation
> mechanism work for other things?
Relocation is the same for I2C.

It is also possible to relocate SMC1 and SMC2 parameter RAM but only=20
with a micropatch.
Today, the kernel only implements relocation of SMC1, and it relocates=20
it at a fixed address just after SMC2 at offset 0x1FC0.
>
> How about checking for the existing specific-SoC compatibles?
What do you mean ?

Christophe

---
Ce courrier =C3=A9lectronique ne contient aucun virus ou logiciel malve=
illant parce que la protection avast! Antivirus est active.
http://www.avast.com

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
