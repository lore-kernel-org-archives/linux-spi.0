From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on
 setting driver_override
Date: Mon, 18 Feb 2019 12:14:29 +0100
Message-ID: <CAJKOXPe1CW4k4ivbh4QhKEbuVc3RRNmzUwQcL0BsrAn=hCdjZg@mail.gmail.com>
References: <1550484960-2392-1-git-send-email-krzk@kernel.org> <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@list
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 18 Feb 2019 at 11:40, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Krzysztof,
>
> On Mon, Feb 18, 2019 at 11:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > The problem
> > ===========
> > Several device types (platform, amba, spi etc.) provide a driver_override
> > field.  On sysfs store or during device removal, they kfree() the
> > existing value.
> >
> > However the users are unaware of this and set the driver_override like:
> >
> >         pdev->driver_override = "exynos5-subcmu";
> >
> > which obviously leads to error.
>
> IMHO driver_override is not meant to be set by a driver, only from userspace,
> for binding the device to vfio (is there another use case?).
>
> >   clk: samsung: exynos5: Fix kfree() of const memory on setting
> >     driver_override
> >   slimbus: ngd: Fix kfree() of const memory on setting driver_override
>
> I see all users set override immediately after allocating a platform device.
> Can't they just allocate a platform device using the override name instead?
> What am I missing?

For the clk-exynos5-subcmu.c case, driver registers several
sub-devices. Each sub-devices is a clock controller associated with
power domain. I guess the author wanted to have meaningful names of
these sub-devices (DISP, CAM etc. like names of power domains),
instead of just exynos5-subcmu.1, exynos5-subcmu.2 ...

If driver_override should not be used for such case, then I could
replace it with what you said.

For the other uses of driver_override (drivers/rpmsg/rpmsg_internal.h
and drivers/slimbus/qcom-ngd-ctrl.c) I don't know.

Best regards,
Krzysztof
