From: christophe leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1 parameter
 RAM
Date: Fri, 03 Oct 2014 22:15:11 +0200
Message-ID: <542F03CF.8010900@c-s.fr>
References: <20141003125609.5BEA11AB276@localhost.localdomain> <20141003144420.GC24441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	Marcelo Tosatti <marcelo-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>,
	Vitaly Bordug <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>,
	scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141003144420.GC24441-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Le 03/10/2014 16:44, Mark Brown a =E9crit :
> On Fri, Oct 03, 2014 at 02:56:09PM +0200, Christophe Leroy wrote:
>
>> +config CPM1_RELOCSPI
>> +	bool "Dynamic SPI relocation"
>> +	default n
>> +	help
>> +	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be relocat=
ed
>> +	  without micropatch. This activates relocation to a dynamically
>> +	  allocated area in the CPM Dual port RAM.
>> +	  When combined with SPI relocation patch (for older MPC8xx) it av=
oids
>> +	  the "loss" of additional Dual port RAM space just above the patc=
h,
>> +	  which might be needed for example when using the CPM QMC.
> Something like this shouldn't be a compile time option.  Either it
> should be unconditional or it should be triggered in some system
> specific manner (from DT, from knowing about other users or similar).
Can't be unconditional as older versions of mpc8xx (eg MPC860) don't=20
support relocation without a micropatch.
I have therefore submitted a v2 based on a DTS compatible property.

---
Ce courrier =E9lectronique ne contient aucun virus ou logiciel malveill=
ant parce que la protection avast! Antivirus est active.
http://www.avast.com

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
