From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3][V4] dt-bindings: iio: imu: add bindings for ADIS16460
Date: Mon, 29 Jul 2019 17:24:40 -0600
Message-ID: <CAL_JsqLXTnrtCr4hVVc9HrOkkvwGWk02EibdutfUBm4JDnJO5Q@mail.gmail.com>
References: <20190723073641.27801-1-alexandru.ardelean@analog.com>
 <20190723073641.27801-4-alexandru.ardelean@analog.com> <20190727195623.42c8b4f3@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190727195623.42c8b4f3@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Jul 27, 2019 at 12:56 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 23 Jul 2019 10:36:40 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > This change adds device-tree bindings for the ADIS16460.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Really trivial, but convention (as driven by what git am -s does if nothing
> else, is to add extra tags in chronological order.  So Rob would be after
> you.  I tweaked it which I don't always remember to do.

I'd argue it is in chronological order as the submitter added my tag
and then sent it out. If you applied it and added my tag, then it
would be after (but before yours).

> It's not consistent across the kernel but I'll fight for my little corner
> to be :)

More consistency would be nice then there's less tribal knowledge
about maintainers for submitters to learn.

Rob
