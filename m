From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: Issues with cros_ec and "spi: rockchip: check return value of dmaengine_prep_slave_sg"
Date: Mon, 11 Apr 2016 13:54:51 -0400
Message-ID: <CABxcv=kotgZosaLBKV0f1NpwYH8w57k+RT0fS2QL5ZpNWtU-yA@mail.gmail.com>
References: <5681888.LvkE41Ux3K@phil>
	<56FF9741.4040304@rock-chips.com>
	<32438337.LoARtRoxf0@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>,
	Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <32438337.LoARtRoxf0@phil>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Heiko,

Sorry for the late response, I got this email while I was sick and
forgot to answer when I recovered.

On Sat, Apr 2, 2016 at 9:37 AM, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wrote:
> Hi Shawn,
>
> Am Samstag, 2. April 2016, 17:56:17 schrieb Shawn Lin:
>> =E5=9C=A8 2016/4/2 7:52, Heiko Stuebner =E5=86=99=E9=81=93:
>> > it looks like commit ea9849113343 ("spi: rockchip: check return va=
lue of
>> > dmaengine_prep_slave_sg") negatively affects the cros_ec spi backe=
nd.
>> >
>> > During boot on the most recent mainline kernel I get:
>> >
>> > [    1.025480] cros-ec-spi spi0.0: Chrome EC device registered
>> > [    1.641636] input: cros_ec as
>> > /devices/platform/ff110000.spi/spi_master/spi0/spi0.0/ff110000.spi=
:ec@0
>> > :keyboard-controller/input/input0 [    2.340214] cros-ec-spi spi0.=
0: EC
>> > failed to respond in time
>> > [    2.357735] cros-ec-spi spi0.0: packet too long (249 bytes, exp=
ected
>> > 4) [    2.470353] cros-ec-spi spi0.0: EC failed to respond in time
>> > [    2.508495] cros-ec-spi spi0.0: packet too long (249 bytes, exp=
ected
>> > 4) [    2.620176] cros-ec-spi spi0.0: EC failed to respond in time
>> > [    2.637345] cros-ec-spi spi0.0: packet too long (249 bytes, exp=
ected
>> > 4) [    2.750245] cros-ec-spi spi0.0: EC failed to respond in time
>> > [    2.767519] cros-ec-spi spi0.0: packet too long (249 bytes, exp=
ected
>> > 4)
>> >
>> > The cros-ec works ok after boot without further errors [aka keyboa=
rd
>> > and everything working correctly] and I haven't been able to figur=
e out
>> > what goes wrong, but was able to bisect the issue down to the comm=
it
>> > mentioned above.
>>
>> Which Soc I can reproduce it?
>
> I can see that on both a veyron-pinky as well as a veyron-jerry, so t=
he
> rk3288-based devices.
>
>
>> I'm not able to find out how this commit to break the cros-ec. So I
>> prone to think this commit just expose some issues rather than
>> introducing negatively affects. I guess, before this commit, cros-ec
>> always get successful transfer, but the reality is that the tranfer
>> does failed in the early booting stage but spi-rockchip doesn't log =
out
>> anything. If that is the case, that means spi-rockchip fails to prep=
are
>> sg for some unknown reasons?
>
> That is a possibility.
>

I also agree with this theory. AFAICT the mentioned commit is only
adding some checks so it seems the problem is with on the spi-rockchip
driver.

> I haven't had much experience with both spi and cros-ec and it seems =
I've
> forgotten to also include Javier in my Cc-list who die the cros-ec
> mainlining. I've corrected that now and maybe he has some additional =
idea
> what may go wrong there.
>

Unfortunately I'm neither familiar with Rockchip platforms nor have
access to Rockchip based Chromebooks to reproduce this issue. But I
don't see this error on my Exynos based Chromebooks so that's another
sign that the issue may be in the spi-rockchip driver.

I've added to the cc list to Enric and Tomeu who were working on the
cros_ec drivers lately and AFAIK have access to some Rockchip
Chromebooks.

>> > Reverting the patch silences the cros-ec again. I'll try to look i=
nto it
>> > further, but maybe you also have an idea what might go wrong.
>
>

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
