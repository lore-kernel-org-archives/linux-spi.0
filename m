From: Christian Hartmann <cornogle@googlemail.com>
Subject: Re: Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Mon, 24 Aug 2015 15:25:57 +0200
Message-ID: <CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
References: <CAKor6TdKrQrvXTPU=fzL9LTCBbyc9WAbLnYdObY+Wu73g1w6Fg@mail.gmail.com>
 <CAKor6Tep1jjOnoPn7e5Djird3RVDNP8Gjcb8HOKO6g-_R5++VQ@mail.gmail.com>
 <20150819134328.GU1552@lahna.fi.intel.com>
 <CAKor6Tc6RDW+2uuX2yMszk3O69=6QTPdd+emC-m_Cro67VPR8g@mail.gmail.com>
 <20150820094542.GC30005@lahna.fi.intel.com>
 <CAKor6Te-DSDxx711-EQi=fw46nNPGnQNqhj-+6upBxhOOp5XvA@mail.gmail.com>
 <20150820115845.GF30005@lahna.fi.intel.com>
 <CAKor6Teq=Aoa6WYkTEVpjBPsWziL-o5FzQHxJWOMeaTrMzXpMg@mail.gmail.com>
 <20150821074310.GM30005@lahna.fi.intel.com>
 <CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
 <20150824085140.GA5647@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, jarkko.nikula@linux.intel.com,
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 dan.carpenter@oracle.com
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150824085140.GA5647@ck-lbox>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

Hi,

2015-08-24 10:51 GMT+02:00 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>:
>> What is with the spi_irq = -1 ?? is this a problem here?
>
> The IRQ needs pulled from the ACPI as well, having no IRQ
> specified will not interfer with basic functionality of the
> driver but will become a problem eventually.
>
> Thanks,
> Charles

ok, I will have an eye on it these days for the IRQ.
For me its looking that the pxa2xx does not have an irq yet,
nor an dma channel (thats should be fine, as I understand it correctly)

actually I cleanup and want to rework / begin with a new v2 patch
series, but first it should drive this chip  before beginning with a
v2 patch.

one more question: the function devm_gpio_request_one() which is used
here to request "arizona /RESET"

<code in arizona-core.c>

/* Start out with /RESET low to put the chip into reset */
ret = devm_gpio_request_one(arizona->dev, arizona->pdata.reset,
GPIOF_DIR_OUT | GPIOF_INIT_LOW,
"arizona /RESET");
</code>

the string arizona /RESET, where is this documented, where can I find
it? It fails here, and my question is, is this string correct at all
for my case? Should it be called only "reset" in my case??

All I have found is:
Documentation/devicetree/bindings/mfd/arizona.txt:  - wlf,reset : GPIO
specifier for the GPIO controlling /RESET

in devres.c its documented as a label only:
@label: a literal description string of this GPIO

I am curios about the answers, anyway I will change it, it looks
faulty (but do not know why exactly at all :) )

cheers
chris
