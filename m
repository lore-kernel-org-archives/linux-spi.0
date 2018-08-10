From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
Date: Fri, 10 Aug 2018 09:27:05 -0700
Message-ID: <CAD=FV=Xu986JWnwC_D6OdUbers4fGf=ExS_z-J_t=QqHOhs1PA@mail.gmail.com>
References: <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org> <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk> <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810161329.GF20971@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Fri, Aug 10, 2018 at 9:13 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Aug 10, 2018 at 08:40:17AM -0700, Doug Anderson wrote:
>> On Fri, Aug 10, 2018 at 3:52 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > This is more about matching the data rate between the two drivers - the
>> > clock framework could (and possibly should) reasonably return an error
>> > here, we're trying to ensure that drivers and controllers work well
>> > together here.
>
>> The clock framework should be able to accomplish what you want.  If
>> you just request the rate it will do its best to make the rate
>> requested.  If we want to see what clock would be set before setting
>
> The request could be massively off the deliverable rate - 50% or more.

Agreed.  If the clock is massively off and that causes problems then
someone will need to debug it and find a solution.  I'm not aware of
us being in that case in the driver in question.


>> >> 3. If you really truly need code in the SPI driver then make sure you
>> >> include a compatible string for the SoC and have a table in the driver
>> >> that's found with of_device_get_match_data().  AKA:
>
>> >>   compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";
>
>> > A controller driver really shouldn't need to be open coding anything.
>
>> It wouldn't be open-coding, it would be a different way of specifying
>> things.  In my understanding it's always a judgement call about how
>
> If you're saying we need clock rate selection logic (which is what it
> sounds like) rather than data then that seems like a problem.

We're talking past each other I think.  Maybe a concrete example helps?

---

IMO the line marked "/* UNNEEDED */" below should be removed:


spi0: spi@880000 {
    compatible = "qcom,geni-spi";
    ...
    spi-max-frequency = <50000000>;  /* UNNEEDED */

    device@0 {
        spi-max-frequency = <25000000>;
        ...
    }
};

---

Said another way: I don't think we should specify the
spi-max-frequency of the _master_ in the device tree.  If there is
_really_ no way to get the max speed from the clock framework and we
_really_ need a per-controller max speed on all geni controllers on
SDM845 then IMO the above should be:

spi0: spi@880000 {
    compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";
    ...

    device@0 {
        spi-max-frequency = <25000000>;
        ...
    }
};

...and then the driver should say "oh, I have a compatible string of
"qcom,geni-spi-sdm845" so I know my controller's max frequency must be
50 MHz.  It can get that information using of_device_get_match_data().

---

Hopefully that's clearer?


-Doug
