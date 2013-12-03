From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 09/11] ARM: shmobile: r8a7791: MSIOF platform device
Date: Tue, 3 Dec 2013 11:12:32 +0100
Message-ID: <CACRpkdbvrYgRh7cK0N1HrcxkYzzu9Qw4yAoQwj4f9pEf0r1qQw@mail.gmail.com>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
	<1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
	<1385921962-19843-9-git-send-email-takasi-y@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: takasi-y@ops.dti.ne.jp
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385921962-19843-9-git-send-email-takasi-y@ops.dti.ne.jp>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Dec 1, 2013 at 7:19 PM,  <takasi-y@ops.dti.ne.jp> wrote:

> From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
>
> Define resources for msiof0,1,2. HWM says there is msiof3, but omit
> it because its clock, reset and irqs are not seen on HWM. Anyway, only
> msiof0 is registerd, so far, because others lack of chance for testing.
> msiof0 has id=1 (spi_sh_msiof.1), for a compatibility with BSP.
>
> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

So why is this new shiny device not registered from the device
tree instead of adding more hard-coded platform devices to the
ARM tree? The add_standard_devices() seem to add everything
from the DT just fine.

NAK.

Yours,
Linus Walleij
