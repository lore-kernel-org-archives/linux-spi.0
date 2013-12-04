From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: add bcm63xx HSSPI driver
Date: Wed, 4 Dec 2013 15:28:25 +0100
Message-ID: <CAOiHx==Lp7FFCCWaSiohvdAyzErBuz5n7sUVs1+A4S1axD9qCA@mail.gmail.com>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
 <1385811726-6746-6-git-send-email-jogo@openwrt.org> <20131204133823.GS29268@sirena.org.uk>
 <CAOiHx==utbmYUS4BLoSaaGi91Kw5voQ2vFiA97GLmwn8yU19Dw@mail.gmail.com> <20131204140853.GU29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131204140853.GU29268-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Dec 4, 2013 at 3:08 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Dec 04, 2013 at 03:04:48PM +0100, Jonas Gorski wrote:
>> On Wed, Dec 4, 2013 at 2:38 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> > This ought to be disable_unprepare().  It would also be better to move
>> > this to runtime PM (you can set auto_runtime_pm to have the core manage
>> > the enable and disable for you) since that will save a bit of power.
>
>> I already set auto_runtime_pm to true. I basically copied what's
>> currently in spi-bcm63xx.c *coughs*. Is there anything else needed
>> besides what you mentioned?
>
> You'll need to call pm_runtime_enable() and so on to turn on runtime PM
> in probe() and reverse that in remove() but otherwise no, just adding
> the runtime callbacks should be fine.

I see. Looks like I just copied your oversight from
5355d96d6fb56507761f261a23c0831f67fa0e0f ("spi/bcm63xx: Convert to
core runtime PM") :P I'll add that to my list of things to fix.

Grepping through drivers/spi, I see a few drivers not calling
pm_runtime_enable(), but setting auto_runtime_pm to true, and a few
doing the opposite. These should probably aligned, too.


Regards
Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
