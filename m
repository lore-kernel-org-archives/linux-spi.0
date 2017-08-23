From: "Lad, Prabhakar" <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Suggestion Needed on Demuxer to Select Slave Devices
Date: Wed, 23 Aug 2017 10:17:20 +0100
Message-ID: <CA+V-a8snXJhHbFC5TTEj49k2hL7pQzsZBg9E2PBTXJJpwNw6Bg@mail.gmail.com>
References: <CA+V-a8tXatbmx4F0uHOjE6dMyb2n0gBVLpn3hjW-reT6gFykOw@mail.gmail.com>
 <CAMuHMdWNTy=ofTvRkMioC+1f9m1JLDXj+JNEP2E9m06=cRybww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWNTy=ofTvRkMioC+1f9m1JLDXj+JNEP2E9m06=cRybww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

Seems like my earlier reply didn=E2=80=99t make to the mailing list, so
replying back again.

On Tue, Aug 22, 2017 at 12:56 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> Hi Lad,
>
> On Tue, Aug 22, 2017 at 1:06 PM, Lad, Prabhakar
> <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> I am writing a Linux SPI slave driver, on the latest kernel, and
>> wanted a suggestion on how the driver could fit in the latest kernel
>> with DT.
>>
>> I have SPI controller which is connected to decoder [1], the SPI
>> controller has 2 chip selects, but only one (cs0) is connected to the
>> decoder.
>
> ... to e.g. G2A of the decoder?
>
the chip select is connected to the G1, which is active high, G2A/G2B
are grounded [1].

>> The decoder has 8 slave devices connected to it, which can be can be
>> selected by gpios from the muxer.
>
> So the A/B/C inputs of the decoder are connected to GPIOs?
>
Yes A/B/C are the inputs to the decoder which are GPIO's.

[1] https://pasteboard.co/GGXwYM8S.jpg

Cheers,
--Prabhakar
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
