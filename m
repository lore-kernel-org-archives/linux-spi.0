From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 10/11] ARM: shmobile: koelsch: pinctrl map for MSIOF0
Date: Tue, 3 Dec 2013 11:13:35 +0100
Message-ID: <CACRpkdY7XppOpgCS4JmQFKhYPSHk4-sdse8wsQ2dj72TtoL8WA@mail.gmail.com>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
	<1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
	<1385921962-19843-10-git-send-email-takasi-y@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: takasi-y@ops.dti.ne.jp
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385921962-19843-10-git-send-email-takasi-y@ops.dti.ne.jp>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Dec 1, 2013 at 7:19 PM,  <takasi-y@ops.dti.ne.jp> wrote:

> From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
>
> Enable msifo0_{clk,sync,rx,tx} pins for MSIOF driver.
>
> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

If this device is registered from the device tree, the pin control
business can also be done from the device tree.

NAK.

Yours,
Linus Walleij
