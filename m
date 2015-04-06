From: Jonathan Richardson <jonathar@broadcom.com>
Subject: Re: [PATCH 2/4] spi: bcm53xx: Refactor to make driver nonspecific
 to 53xx SoCs
Date: Mon, 6 Apr 2015 11:30:18 -0700
Message-ID: <5522D0BA.2050805@broadcom.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com> <1428002603-21892-3-git-send-email-jonathar@broadcom.com> <CAHp75Vf0JrB5pqNEouLzyOf5mmi05Ut_cybd37suTrLbJOFHKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	"Mark Rutland" <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree <devicetree@vger.kernel.org>,
	Rafal Milecki <zajec5@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vf0JrB5pqNEouLzyOf5mmi05Ut_cybd37suTrLbJOFHKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 15-04-03 06:35 AM, Andy Shevchenko wrote:
> On Thu, Apr 2, 2015 at 10:23 PM, Jonathan Richardson
> <jonathar@broadcom.com> wrote:
>> The Broadcom MSPI controller is used on various SoCs. It is being
>> renamed so that it can be extended and reused on other chips. It is
>> renamed to bcm-mspi.
>>
> What if you resend this one with -M -C applied?
> 
> 

I'm not seeing any difference in the patches unfortunately. I'll keep
playing with it and re-send if I can find a way to improve it.

The changes are just renaming variables, structures, functions, file
name to get rid of 53xx and replace with mspi. The config is renamed
from SPI_BCM53XX to SPI_BCMA_MSPI.
