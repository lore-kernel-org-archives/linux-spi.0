From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V2] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Fri, 20 Jul 2018 16:32:47 -0700
Message-ID: <CAD=FV=WMAyg8Z+uamOyQ4iBs_SgTG3VTuw1t5u++FZtEpRWH8w@mail.gmail.com>
References: <1532087461-3474-1-git-send-email-dkota@codeaurora.org>
 <1532087461-3474-2-git-send-email-dkota@codeaurora.org> <CAD=FV=VEQwudhCU0h7muB6ZM1WPETW0h4-=wo_=jgk0gyqfhBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Timur Tabi <timur@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=VEQwudhCU0h7muB6ZM1WPETW0h4-=wo_=jgk0gyqfhBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Fri, Jul 20, 2018 at 3:53 PM, Doug Anderson <dianders@chromium.org> wrote:
>> +               mas->oversampling = 1;
>> +               /* Transmit an entire FIFO worth of data per IRQ */
>> +               mas->tx_wm = 1;
>> +               geni_se_get_wrapper_version(se, major, minor, step);
>
> In v1 Stephen said:
>
>> Drop extra parenthesis.
>
> I'll further add that I'd prefer it if you based your series atop
> <https://patchwork.kernel.org/patch/10412417/> which changes the
> prototype here.

Whoops.  Extra parenthesis was actually referring to the line below
this one, AKA:


> +               if ((major == 1) && (minor == 0))
> +                       mas->oversampling = 2;

...that still applies.  ...but then ignore my comment suggesting that
you base your series atop Stephen's.  You already did that.  Certainly
you should mention somewhere in your email that your patch is based on
his.


-Doug
