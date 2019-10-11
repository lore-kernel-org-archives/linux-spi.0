From: Yizhuo Zhai <yzhai003@ucr.edu>
Subject: Re: Potential NULL pointer deference in spi
Date: Thu, 10 Oct 2019 22:31:28 -0700
Message-ID: <CABvMjLTrGprdgFTP-+2XC_p+vE+tVWeYvyuLGkKj1dY7KR+JDg@mail.gmail.com>
References: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
 <f3ce1620-c421-b41f-440b-efe3ff6e91fe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
To: Eric Dumazet <eric.dumazet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f3ce1620-c421-b41f-440b-efe3ff6e91fe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Eric:

My apologies for bothering, we got those report via static analysis
and haven't got a good method to verify the path to trigger them.
Therefore I sent those email to you maintainers first since you
know much better about the details. Sorry again for your time and
I take your suggestions.

On Wed, Oct 9, 2019 at 10:48 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 10/9/19 10:37 PM, Yizhuo Zhai wrote:
> > Hi All:
> >
> > drivers/spi/spi.c:
> >
> > The function to_spi_device() could return NULL, but some callers
> > in this file does not check the return value while directly dereference
> > it, which seems potentially unsafe.
> >
> > Such callers include spidev_release(),  spi_dev_check(),
> > driver_override_store(), etc.
> >
> >
>
>
> Many of your reports are completely bogus.
>
> I suggest you spend more time before sending such emails to very large audience
> and risk being ignored at some point.
>
> Thanks.



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
