From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
Date: Fri, 10 Aug 2018 09:47:44 -0700
Message-ID: <CAD=FV=X=t4txkWKkO2qiCf0m6iSLWhckr++G+eYJL6REMFdTyQ@mail.gmail.com>
References: <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org> <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk> <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk> <CAD=FV=Xu986JWnwC_D6OdUbers4fGf=ExS_z-J_t=QqHOhs1PA@mail.gmail.com>
 <20180810164345.GH20971@sirena.org.uk>
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
In-Reply-To: <20180810164345.GH20971@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Fri, Aug 10, 2018 at 9:43 AM, Mark Brown <broonie@kernel.org> wrote:
>> IMO the line marked "/* UNNEEDED */" below should be removed:
>
>>     ...
>>     spi-max-frequency = <50000000>;  /* UNNEEDED */
>
> This is a line in the device tree (which I agree shouldn't be there),
> not code in the SPI driver?

My whole point was that the line above shouldn't be there.  If you
agree to that then we're done.  Everything else was my suggestions of
ways the driver would deal with that line not being there.

-Doug
