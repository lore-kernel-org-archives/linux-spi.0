From: Martin Guy <martinwguy@gmail.com>
Subject: Re: [PATCH v7 2/2] ep93xx: SPI driver platform support code
Date: Sun, 9 May 2010 17:57:19 +0100
Message-ID: <AANLkTikVbmYVjTcSGl72bBKRBlXoGF5KGRveuUInov-0@mail.gmail.com>
References: <cover.1273120206.git.mika.westerberg@iki.fi>
	<c4be393041bfab8d1c27d43dd5a2526222d1d4ef.1273120206.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net, grant.likely@secretlab.ca,
	hsweeten@visionengravers.com, ryan@bluewatersys.com,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c4be393041bfab8d1c27d43dd5a2526222d1d4ef.1273120206.git.mika.westerberg@iki.fi>
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

On 5/6/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> This patch adds platform side support code for the EP93xx SPI driver. This
>  includes clock, resources and muxing. There is a new function: ep93xx_register_spi()
>  which can be used by board support code to register new SPI devices for the
>  board.
>
>  Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
>  Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Acked-by: Martin Guy <martinwguy@gmail.com>
