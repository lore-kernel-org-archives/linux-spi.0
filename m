From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH 1/2] spi_imx.c: CSPI3 irq is 0 on imx25
Date: Thu, 6 Jan 2011 12:26:17 +0100
Message-ID: <AANLkTimpTUz_Fizef09urPBR8vP80KU-5yApjzGWFwc0@mail.gmail.com>
References: <1293102730-32528-1-git-send-email-richard.genoud@gmail.com> <20101223185921.GB20384@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101223185921.GB20384@angua.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2010/12/23 Grant Likely <grant.likely@secretlab.ca>:
> On Thu, Dec 23, 2010 at 12:12:09PM +0100, Richard Genoud wrote:
>> On imx25 soc, MX25_INT_CSPI3 is 0
>> (cf arch/arm/plat-mxc/include/mach/mx25.h).
>> So, the test (spi_imx->irq <=3D 0) returned an error
>> for this platform.
>> This patch corrects this behaviour.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>> =C2=A0drivers/spi/spi_imx.c | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
>> index 55a38e2..793ae99 100644
>> --- a/drivers/spi/spi_imx.c
>> +++ b/drivers/spi/spi_imx.c
>> @@ -847,7 +847,7 @@ static int __devinit spi_imx_probe(struct platfo=
rm_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 spi_imx->irq =3D platform_get_irq(pdev, 0);
>> - =C2=A0 =C2=A0 if (spi_imx->irq <=3D 0) {
>> + =C2=A0 =C2=A0 if (spi_imx->irq < 0) {
>
> I *really* don't want to apply this. =C2=A0The kernel is slowly movin=
g
> toward NO_IRQ =3D=3D 0 for all architectures. =C2=A0This patch is a s=
tep in the
> wrong direction because it will break with ARM starts using 0 for
> NO_IRQ.
>
> I would accept a change to spi_imx->irq =3D=3D NO_IRQ however.
>
> g.
>

Actually, the description of the patch is wrong, but not the patch itse=
lf.
The test "if (spi_imx->irq <=3D 0)" is not testing the IRQ value, but
the return value of platform_get_irq().
And platform_get_irq() can return an error (-ENXIO) or the IRQ value it=
 found.
So, as we are testing if platform_get_irq() failed or not, the test
should be "if (spi_imx->irq < 0)"

If you agree with that, I will resend the patch with a good description=
=2E

richard.


--=20
for me, ck means con kolivas and not calvin klein... does it mean I'm a=
 geek ?
