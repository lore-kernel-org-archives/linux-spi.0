From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/4] spi: bcm53xx: Refactor to make driver nonspecific to
 53xx SoCs
Date: Fri, 3 Apr 2015 16:35:10 +0300
Message-ID: <CAHp75Vf0JrB5pqNEouLzyOf5mmi05Ut_cybd37suTrLbJOFHKA@mail.gmail.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com>
	<1428002603-21892-3-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi@vger.kernel.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree <devicetree@vger.kernel.org>,
	Rafal Milecki <zajec5@gmail.com>
To: Jonathan Richardson <jonathar@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428002603-21892-3-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Apr 2, 2015 at 10:23 PM, Jonathan Richardson
<jonathar@broadcom.com> wrote:
> The Broadcom MSPI controller is used on various SoCs. It is being
> renamed so that it can be extended and reused on other chips. It is
> renamed to bcm-mspi.
>
What if you resend this one with -M -C applied?


-- 
With Best Regards,
Andy Shevchenko
