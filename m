From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v5 01/16] spi/spi-atmel: fix master->num_chipselect
 wrongly set.
Date: Sat, 02 Mar 2013 23:15:35 +0000
Message-ID: <20130302231535.8E6043E35BE@localhost>
References: <1361861289-30332-1-git-send-email-wenyou.yang@atmel.com>
 <1361861289-30332-2-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: richard.genoud@gmail.com, JM.Lin@atmel.com, nicolas.ferre@atmel.com,
 linux-kernel@vger.kernel.org, wenyou.yang@atmel.com,
 spi-devel-general@lists.sourceforge.net, plagnioj@jcrosoft.com
To: Wenyou Yang <wenyou.yang@atmel.com>, linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1361861289-30332-2-git-send-email-wenyou.yang@atmel.com>
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

On Tue, 26 Feb 2013 14:47:54 +0800, Wenyou Yang <wenyou.yang@atmel.com> wrote:
> if the spi property "cs-gpios" is set as below:
> 
> 	cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
> 
> the master->num_chipselect will wrongly be set to 0,
> and the spi fail to probe.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: spi-devel-general@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org

I think I've got this bug fixed in the core spi code. Give it a couple
of days and retest with linux-next.

g.
