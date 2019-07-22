From: Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH 1/4][V3] spi: Add optional stall delay between cs_change transfers
Date: Mon, 22 Jul 2019 22:27:47 +0300
Message-ID: <CA+U=DspSkWzwVp38No9tGYb0_zc2yVP5jFcLsOd2aLi2WxaW-w@mail.gmail.com>
References: <20190722124747.4792-1-alexandru.ardelean@analog.com>
 <20190722124747.4792-2-alexandru.ardelean@analog.com> <20190722163202.GG4756@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <michael.hennerich@analog.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722163202.GG4756@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 22, 2019 at 8:42 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jul 22, 2019 at 03:47:44PM +0300, Alexandru Ardelean wrote:
> > Some devices like the ADIS16460 IMU require a longer period between
> > transfers, i.e. between when the CS is de-asserted and re-asserted. The
> > default value of 10us is not enough. This change makes the delay
> > configurable for when the next CS change goes active, allowing the default
> > to remain 10us is case it is unspecified.
>
> For the third time:
>
> | This looks like cs_change_delay.
>
> >  #define      SPI_NBITS_QUAD          0x04 /* 4bits transfer */
> >       u8              bits_per_word;
> >       u8              word_delay_usecs;
> > +     u8              cs_change_delay;
> >       u16             delay_usecs;
> >       u32             speed_hz;
> >       u16             word_delay;
>
> This patch doesn't apply and even if it did it won't compile because you
> are trying to add a field with the same name as an existing one.

oooohhhhhhhh
now i see;

well, my fault here;
i was basing my patchset on top of branch iio/togreg from Jonathan's
tree for the IMU:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=togreg
[ typically that's the base branch for new IIO drivers ]

that one is a bit behind, and does not contain the cs_change_delay
stuff you mentioned;
also, i will admit that sometimes, some review comments are not
completely obvious to me;
i should have checked the SPI tree before opening my mouth, but this
will [hopefully] serve me as a learning experience when sending
multi-subsystem patches
when sending to a single subsystem, it's clear; when sending to 2, i
get a bit lost

i do feel a bit bad for the noise i caused, but it's not the worst
thing i did today

anyway: disregard this, and i will sync with Jonathan about how to
proceed with this patch just for IIO;

thanks for your time and sorry for the noise
Alex
