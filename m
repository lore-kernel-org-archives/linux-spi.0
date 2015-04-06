From: Jonathan Richardson <jonathar@broadcom.com>
Subject: Re: [PATCH 2/4] spi: bcm53xx: Refactor to make driver nonspecific
 to 53xx SoCs
Date: Mon, 6 Apr 2015 11:58:20 -0700
Message-ID: <5522D74C.9090906@broadcom.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com> <1428002603-21892-3-git-send-email-jonathar@broadcom.com> <CAHp75Vf0JrB5pqNEouLzyOf5mmi05Ut_cybd37suTrLbJOFHKA@mail.gmail.com> <CACna6ryc+2-3+G7WT0XerNkFgop44EP9zMvrVT+mMtCVjGPLuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"Kumar Gala" <galak@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree <devicetree@vger.kernel.org>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACna6ryc+2-3+G7WT0XerNkFgop44EP9zMvrVT+mMtCVjGPLuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 15-04-06 03:18 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 3 April 2015 at 15:35, Andy Shevchenko <andy.shevchenko@gmail.com>=
 wrote:
>> On Thu, Apr 2, 2015 at 10:23 PM, Jonathan Richardson
>> <jonathar@broadcom.com> wrote:
>>> The Broadcom MSPI controller is used on various SoCs. It is being
>>> renamed so that it can be extended and reused on other chips. It is
>>> renamed to bcm-mspi.
>>>
>> What if you resend this one with -M -C applied?
>=20
> Definitely, right now I can't really review this patch (and I want to=
).
>=20

Thanks Rafal for the review. Please see previous reply to Andy and let
me know if I'm missing something.
