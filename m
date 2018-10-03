From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] spi: slave: Fix missing break in switch
Date: Wed, 3 Oct 2018 20:22:05 +0200
Message-ID: <8fe04496-4e01-9ac2-248d-28bcbe3752d1@embeddedor.com>
References: <20181003123328.GA29471@embeddedor.com>
 <CAMuHMdX2YL2PG390ej0WMct7DciAbzO=66z7TJ-VnS8_phjdaQ@mail.gmail.com>
 <20181003150111.GD7132@sirena.org.uk>
 <37edd7c9-c93f-49a1-6621-880d8f88f345@embeddedor.com>
 <CAMuHMdXyn6MYETdCAueXSKDeZXGxN2JJWX7bsE8QiUZNveeDfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXyn6MYETdCAueXSKDeZXGxN2JJWX7bsE8QiUZNveeDfg@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 10/3/18 5:10 PM, Geert Uytterhoeven wrote:
> Hi Gustavo,
> 
> On Wed, Oct 3, 2018 at 5:05 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>> On 10/3/18 5:01 PM, Mark Brown wrote:
>>> On Wed, Oct 03, 2018 at 04:46:45PM +0200, Geert Uytterhoeven wrote:
>>>> On Wed, Oct 3, 2018 at 2:57 PM Gustavo A. R. Silva
>>>
>>>>>         case CMD_REBOOT:
>>>>>                 dev_info(&priv->spi->dev, "Rebooting system...\n");
>>>>>                 kernel_restart(NULL);
>>>>> +               break;
>>>
>>>> Alternatively, kernel_restart() and friends could be marked __noreturn.
>>>
>>> Yes, that seems more sensible though there's no harm in this patch even
>>> with that.  It'd definitely avoid other issues in future.
>>
>> I'll include the __noreturn in addition to the break statement.
>> I'll send v2 shortly.
> 
> Please note that adding __noreturn is not a trivial task, due to the complex
> call chains, and the different implementations on the various architectures
> and platforms.  So that will be a big patch series.
> 

I see. In that case, it might be an interesting side project.

I appreciate the feedback, Geert.
--
Gustavo
