From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/7] reset: make RESET_CONTROLLER a select'ed option
Date: Fri, 06 Nov 2015 10:29:54 +0100
Message-ID: <4121507.a7FHqRxKcX@wuerfel>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com> <3770393.BLNOaUSB5Q@wuerfel> <CAK7LNARjtTXUNQFDtcqtxUo0c49h_kfNCf-2WZUEFXmttZoFyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	linux-mips@linux-mips.org, kernel@stlinux.com,
	David Airlie <airlied@linux.ie>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Will Deacon <will.deacon@arm.com>,
	dri-devel@lists.freedesktop.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alexandre Courbot <gnurou@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Michael Turquette <mturquette@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stephe
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAK7LNARjtTXUNQFDtcqtxUo0c49h_kfNCf-2WZUEFXmttZoFyA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday 06 November 2015 14:58:04 Masahiro Yamada wrote:
> 2015-11-05 23:49 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> [1]
> Why is ARCH_HAS_RESET_CONTROLLER select'ed by
> ARCH_MULTIPLATFORM, but not by others?
> This seems weird.

I tried to avoid having to set this from each platform separately,
and all users of ARCH_HAS_RESET_CONTROLLER on ARM are also
based on ARCH_MULTIPLATFORM. The other platforms are lagging behind
in their conversion and use neither reset controllers not
multiplatform. If anyone wants to make them use reset controllers,
we probably want them to use multiplatform as well.

> We do not have such options like
>   ARCH_HAS_PINCTRL,  ARCH_HAS_COMMON_CLK...

We could of course change it in one direction or another, but it
didn't seem urgent here.

> [2]
> The difference is that yours is adding per-driver options such as
> RESET_SOCFPGA, RESET_BERLIN, etc.
> I think this is a good idea.
> 
> But, I notice lowlevel drivers select RESET_CONTROLLER,
> for example, RESET_SOCFPGA select RESET_CONTROLLER.
> 
> We generally do the opposite in other subsystems, I think.
> 
> 
> For example, the whole of clk menu is guarded by "depends on COMMON_CLK".
> 
> menu "Common Clock Framework"
>          depends on COMMON_CLK
> 
>      <bunch of low-level drivers>
> 
> endmenu
> 
> 
> Likewise for pinctrl.

We can do that too, either way works for me, and we are using both
in other parts of the kernel. REGMAP is an example for another subsystem
that gets selected by each driver that relies on the framework.

The practical difference is only in the case that the subsystem
is enabled (e.g. by using ARCH_MULTIPLATFORM) but all reset drivers
are disabled. A device driver using the API in one case will see
the stubbed-out inline helpers and not contain any object code
that relies on non-NULL return values from them, while in the
other case it calls into the subsystem code to get the same
return value at runtime.

If you volunteer to clean up my patch, feel free to choose between
the two options as you like.

	Arnd
