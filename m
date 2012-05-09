From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 07/10] spi: s3c64xx: Remove the 'set_level' callback from
 controller data
Date: Wed, 9 May 2012 16:01:15 +0530
Message-ID: <CAJe_ZhczJhGxUTgdD57n_R7Nz8oD6a075LMzjcejO6QkrHTXTg@mail.gmail.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
	<1336514694-22393-8-git-send-email-thomas.abraham@linaro.org>
	<201205091120.41978.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Abraham <thomas.abraham@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201205091120.41978.heiko@sntech.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 9 May 2012 14:50, Heiko St=FCbner <heiko@sntech.de> wrote:
> Am Mittwoch, 9. Mai 2012, 00:04:51 schrieb Thomas Abraham:
>> The set_level callback in the controller data, which is used to conf=
igure
>> the slave select line, cannot be supported when migrating the driver=
 to
>> device tree based discovery. Since all the platforms currently use g=
pio
>> as the slave select line, this callback can be removed from the
>> controller data and replaced with call to gpio_set_value in the driv=
er.
>
> I was quite fond of the set_level callback. On one of the machines I'=
m working
> on there is some sort of multiplexer (TI-sn74cbtlv3257) sitting betwe=
en the
> controller and spi devices to provide support for more than one devic=
e.
> So I was doing the switch to the correct device in the set_level call=
back,
> which worked quite well.
>
I suppose you should still be able to do that defining virtual gpios ba=
cked
by appropriate physical mux'ing of lines ?

-jassi
