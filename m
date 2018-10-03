From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] spi: slave: Fix missing break in switch
Date: Wed, 3 Oct 2018 17:05:04 +0200
Message-ID: <37edd7c9-c93f-49a1-6621-880d8f88f345@embeddedor.com>
References: <20181003123328.GA29471@embeddedor.com>
 <CAMuHMdX2YL2PG390ej0WMct7DciAbzO=66z7TJ-VnS8_phjdaQ@mail.gmail.com>
 <20181003150111.GD7132@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003150111.GD7132@sirena.org.uk>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 10/3/18 5:01 PM, Mark Brown wrote:
> On Wed, Oct 03, 2018 at 04:46:45PM +0200, Geert Uytterhoeven wrote:
>> On Wed, Oct 3, 2018 at 2:57 PM Gustavo A. R. Silva
> 
>>>         case CMD_REBOOT:
>>>                 dev_info(&priv->spi->dev, "Rebooting system...\n");
>>>                 kernel_restart(NULL);
>>> +               break;
> 
>> Alternatively, kernel_restart() and friends could be marked __noreturn.
> 
> Yes, that seems more sensible though there's no harm in this patch even
> with that.  It'd definitely avoid other issues in future.
> 

I'll include the __noreturn in addition to the break statement.
I'll send v2 shortly.

Thank you both for the feedback.
--
Gustavo
