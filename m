From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH V2 2/8] soc: qcom: geni: Support for ICC voting
Date: Fri, 20 Mar 2020 09:45:34 -0700
Message-ID: <CAE=gft5Uucr83DoQqaE7_8_H=ExnkPBQvRiUK_+LxOMeadam_g@mail.gmail.com>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-3-git-send-email-akashast@codeaurora.org>
 <CAE=gft4_Su4+SXWAW_HWy5BF1mH7QaDHCiwAAhrNaekTeU57rA@mail.gmail.com> <74851dda-296d-cdc5-2449-b9ec59bbc057@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wsa@the-dreams.de, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>
To: Akash Asthana <akashast@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <74851dda-296d-cdc5-2449-b9ec59bbc057@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Mar 20, 2020 at 4:03 AM Akash Asthana <akashast@codeaurora.org> wrote:
>
> Hi Evan,
>
> +/* Core 2X clock frequency to BCM threshold mapping */
> +#define CORE_2X_19_2_MHZ               960
> +#define CORE_2X_50_MHZ                 2500
> +#define CORE_2X_100_MHZ                        5000
> +#define CORE_2X_150_MHZ                        7500
> +#define CORE_2X_200_MHZ                        10000
> +#define CORE_2X_236_MHZ                        16383
>
> These are all just 50 * clock_rate. Can you instead specify that one
> define of CLK_TO_BW_RATIO 50, and then use clk_get_rate() to get the
> input clock frequency. That way, if these end up getting clocked at a
> different rate, the bandwidth also scales appropriately. Also, can you
> enumerate why 50 is an appropriate ratio?
> -Evan
>
> -Evan
>
> Clock rate for Core 2X is controlled by BW voting only, we don't set clock rate for core 2X clock either by DFS or calling clk_set_rate API like we do for SE clocks from individual driver.
>
> In DT node it's not mentioned as clock.
>
> As discussed in patch@ https://patchwork.kernel.org/patch/11436897/  We are not scaling Core 2X clock based on dynamic need of driver instead we are putting recommended value from HW team for each driver.

Oh I get it. This is pretty opaque, since this table is saying "here
are the bandwidth values that happen to work out to a Core2X clock
rate of N". But it's not obvious why setting the Core2X clock rate to
N is desirable or appropriate. The answer seems to be hardware guys
told us these thresholds work well in practice. And if I'm reading
into it more, probably they're saying these bandwidths are too low to
be worth dynamically managing beyond on/off.

At the very least we should explain some of this in the comment above
these defines. Something like:
/* Define bandwidth thresholds that cause the underlying Core 2X
interconnect clock to run at the named frequency. These baseline
values are recommended by the hardware team, and are not dynamically
scaled with GENI bandwidth beyond basic on/off. */
-Evan
