From: Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] spi: add spi multiplexing functions for dt
Date: Thu, 25 Jan 2018 15:54:25 +0000
Message-ID: <CAF3==ivhZ1AJtNqEmzQpmgy4r0NSz36THe3xADaARsDRbv1vVQ@mail.gmail.com>
References: <1516661472-16452-1-git-send-email-ben.whitten@gmail.com>
 <1516661472-16452-2-git-send-email-ben.whitten@gmail.com> <20180123111123.GB7600@sirena.org.uk>
 <CAF3==it=5_YQVJ9xg8CLzSPw7LQZbCHQHfsufYwwCb=n7x3L0g@mail.gmail.com> <20180124145430.GD9366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180124145430.GD9366-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 24 January 2018 at 14:54, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jan 24, 2018 at 02:01:55PM +0000, Ben Whitten wrote:
>> On 23 January 2018 at 11:11, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> > level.  Things that have their own transfer function would be better off
>> > just being first order SPI controllers I think so that they get access
>> > to everything the framework offers and can correctly advertise
>> > capabilities and so on.
>
>> This runs as a very simple fake SPI controller per bus that the mux is
>> controlling. Having this custom transfer message allowed me to pop
>> in the way my device exposes the downstream devices, through its
>> regmap.
>
> Which like I say is a problem - if your device (which just sounds like a
> SPI controller) has different capabilities and constraints to the parent
> then client drivers won't see that.

Ahh yes I see what you mean, agreed. I have changed my device to be a full
controller.
Thanks for the review.

Ben
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
