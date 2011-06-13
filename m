From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] spi-pl022: Add missing return value update
Date: Mon, 13 Jun 2011 18:13:02 +0200
Message-ID: <BANLkTi=A+Sn7Fx_ta92EGRaz6MLbiAdsdA@mail.gmail.com>
References: <1307962426-19230-1-git-send-email-virupax.sadashivpetimath@stericsson.com>
	<20110613150856.GD18161@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Virupax Sadashivpetimath
	<virupax.sadashivpetimath@stericsson.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110613150856.GD18161@ponder.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 13, 2011 at 5:08 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jun 13, 2011 at 04:23:46PM +0530, Virupax Sadashivpetimath wrote:
>> Return error on out of range cpsdvsr value.
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
>
> It looks like this is a bug fix for v3.0, and probably for -stable too, correct?

ACK

Linus Walleij
