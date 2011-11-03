From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2] spi/pl022: Enable clock in probe
Date: Thu, 3 Nov 2011 17:19:06 +0100
Message-ID: <CACRpkdamE9Qrah9Fc+b86QcohZ7Pnzsh3nNHvdf_6-HCTTPYhQ@mail.gmail.com>
References: <1320335741-5309-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net, Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1320335741-5309-1-git-send-email-ulf.hansson@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 3, 2011 at 4:55 PM, Ulf Hansson <ulf.hansson@stericsson.com> wr=
ote:

> Make sure we enable the clock before leaving probe.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
>
> Changes in v2:
> =A0 =A0 =A0 =A0-Remove runtime_idle

Looking good
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please put this v2 in Russell's tracker.
Linus
