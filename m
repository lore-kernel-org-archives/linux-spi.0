From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/2] SPI: spi_sh_msiof: implement DMA support
Date: Wed, 7 Sep 2011 07:16:46 +0900
Message-ID: <CANqRtoTKxuRzOTcuL9vknNrn_k7HPZCJh3A4iGr9vczrqhfcqA@mail.gmail.com>
References: <Pine.LNX.4.64.1109021706480.4731@axis700.grange>
	<Pine.LNX.4.64.1109021712180.4731@axis700.grange>
	<20110905045911.GE22142@linux-sh.org>
	<Pine.LNX.4.64.1109050925170.13066@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mundt <lethal@linux-sh.org>,
	spi-devel-general@lists.sourceforge.net, linux-sh@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1109050925170.13066@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 5, 2011 at 4:26 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Mon, 5 Sep 2011, Paul Mundt wrote:
>> On Fri, Sep 02, 2011 at 05:13:31PM +0200, Guennadi Liakhovetski wrot=
e:
>> > Use the sh_dma dmaengine driver to support DMA on MSIOF.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

>> > @@ -695,11 +1030,11 @@ static int sh_msiof_spi_remove(struct platf=
orm_device *pdev)
>> >
>> > =A0 =A0 ret =3D spi_bitbang_stop(&p->bitbang);
>> > =A0 =A0 if (!ret) {
>> > + =A0 =A0 =A0 =A0 =A0 sh_msiof_release_dma(p);
>> > =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_disable(&pdev->dev);
>> > =A0 =A0 =A0 =A0 =A0 =A0 free_irq(platform_get_irq(pdev, 0), p);
>> > =A0 =A0 =A0 =A0 =A0 =A0 iounmap(p->mapbase);
>> > =A0 =A0 =A0 =A0 =A0 =A0 clk_put(p->clk);
>> > - =A0 =A0 =A0 =A0 =A0 spi_master_put(p->bitbang.master);
>> > =A0 =A0 }
>> > =A0 =A0 return ret;
>> > =A0}
>>
>> You've also killed off the spi_master_put() here.
>
> Yes, spi_bitbang_stop() does it all already.

So it's a bug fix built-in to a feature patch? If so, please break out
and submit as a fix.

Thanks,

/ magnus
