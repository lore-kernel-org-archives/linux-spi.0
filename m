From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] spi_imx.c: correct the test on platform_get_irq() return value
Date: Fri, 7 Jan 2011 17:41:53 +0100
Message-ID: <AANLkTi=SCQYOTSQGpRnje-+=h5AZTtuaEOT6LO4VQA8T@mail.gmail.com>
References: <AANLkTimpTUz_Fizef09urPBR8vP80KU-5yApjzGWFwc0@mail.gmail.com>
 <1294410361-9092-1-git-send-email-richard.genoud@gmail.com> <AANLkTin0eXCpLD1B0+zABqYcWxzG8+kM1cpRyD+Af_2n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTin0eXCpLD1B0+zABqYcWxzG8+kM1cpRyD+Af_2n@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2011/1/7 Grant Likely <grant.likely@secretlab.ca>:
> On Fri, Jan 7, 2011 at 7:26 AM, Richard Genoud <richard.genoud@gmail.=
com> wrote:
>> The test "if (spi_imx->irq <=3D 0)" is not testing the IRQ value, bu=
t the return value of platform_get_irq().
>> As platform_get_irq() can return an error (-ENXIO) or the IRQ value =
it found, the test should be "if (spi_imx->irq < 0)"
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>
> For the majority of architectures in Linux, 0 is not a valid IRQ for
> devices. =C2=A0Unless there is an actual imx platform that currently
> assigns linux irq 0 to the spi controller then I'd rather not apply
> this change.
actually, there is the imx25 platform:
in arch/arm/plat-mxc/include/mach/mx25.h
line 61 :
#define MX25_INT_CSPI3          0
this is the interrupt assigned for CSPI3.

I doubled check with the imx25 release manual chapter 3.1 (page 51):
http://cache.freescale.com/files/dsp/doc/ref_manual/IMX25RM.pdf
And I made some spi test on the imx25 3stack PDK, the CSPI3 is working
with irq 0.

richard.
