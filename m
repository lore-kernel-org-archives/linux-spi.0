From: Christian Hartmann <cornogle@googlemail.com>
Subject: Re: Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Mon, 10 Aug 2015 10:00:38 +0200
Message-ID: <CAKor6TdLkGZbARmV1CfqUiguH8HAD+oC8VSsH_OkNQ6E-7YVAw@mail.gmail.com>
References: <20150629094854.GB11162@sirena.org.uk>
 <CAKor6TdDPb2qOgdHbeX2w+yQa_ioDM5ak9bk+=jF+cKt_twiXw@mail.gmail.com>
 <20150630103404.GI6321@opensource.wolfsonmicro.com>
 <CAKor6TdKk2OUz4o12RiQBSVZyhD=L4JpBJcYkGE=_6X+ZeQY_g@mail.gmail.com>
 <20150713095359.GM16517@opensource.wolfsonmicro.com>
 <CAKor6Td83zgOS+iHGHGhFW4n26H=tC-QQDuzaHHfybhLeH-jvw@mail.gmail.com>
 <CAKor6TdheYM73aqti362bOnP2GZmX60uuDY5v2eow1vqO9tcKw@mail.gmail.com>
 <20150715081224.GN16517@opensource.wolfsonmicro.com>
 <20150715091709.GK11162@sirena.org.uk>
 <CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com>
 <20150717085434.GO16517@opensource.wolfsonmicro.com>
 <CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, mika.westerberg@linux.intel.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, jarkko.nikula@linux.intel.com,
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 dan.carpenter@oracle.com
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAKor6Tcof3PA3JGD2=4X8mtSak8ka9BVD2L4zdYC4M1yEYEXjg@mail.gmail.com>
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

Hi again,

in the case of CONFIG_OF (this machine has no OF) the arizona_of_get_core_pdata
sets also gpio_defaults for struct pdata, which I had not added into
the #else switch (CONFIG_OF is not set).

All I have is an one example in
Documentation/devicetree/bindings/mfd/arizona.txt.

What should I do here cause I do not now the defaults but they seem to
be needed too and I cannot use devicetree here.
Where can I get the gpio-defaults or how can I use gpiolib to extract
these defaults and gpio pins as expected?



Looking again ( and again at the code), I have to use a function
similar to arizona_of_get_named_gpio to find all of these pins, is
there a function for the acpi case?
I have not the the full view and I am not well-informed yet

cheers
chris

PS: just reading the latest answer and evaluating...
