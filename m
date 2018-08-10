From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
Date: Fri, 10 Aug 2018 09:49:37 -0700
Message-ID: <CAD=FV=Us65kRtn6wtc+cr-ws0b1vYwARbqt0yY+T2BdSFPnfcg@mail.gmail.com>
References: <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org> <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk> <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk> <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Fri, Aug 10, 2018 at 9:29 AM,  <dkota@codeaurora.org> wrote:
> Here are my couple of cents:
> SPI controller maximum frequency can be lesser than or equal to Clock
> framework's maximum
> frequency, so should not rely on the Clock framework.

You could make that argument on other SoCs perhaps, but from what I've
seen in Qualcomm clock drivers there is a hardcoded frequency plan
that takes into account how fast the IP blocks can go.

-Doug
