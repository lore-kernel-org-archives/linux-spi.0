From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH]spi: pl022: add a message state STATE_TIMEOUT for timeout
 transfer
Date: Mon, 21 Jan 2019 14:57:35 +0100
Message-ID: <CACRpkdaX5O6j85L83KyMN3dxjkzrgSdhMRm5BwFb58fdMdA2+w@mail.gmail.com>
References: <20190118033229.22553-1-jiwei.sun@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-spi <linux-spi@vger.kernel.org>
To: Jiwei Sun <jiwei.sun@windriver.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190118033229.22553-1-jiwei.sun@windriver.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 18, 2019 at 4:33 AM Jiwei Sun <jiwei.sun@windriver.com> wrote:

> When transfer timeout, give -EAGAIN to the message's status, and it can
> make the spi device driver choose repeated transimation or not. And if
> transfer timeout, output some useful information for tracing the issue.
>
> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>

This looks very good and helpful!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
