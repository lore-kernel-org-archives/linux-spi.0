From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] Bug fix in commit 178db7d3 triggered a bug in the SPI
 driver for MPC83XX (pdata is NULL).
Date: Fri, 30 Mar 2012 17:16:04 +0200
Message-ID: <OF31A01223.1122F8EE-ONC12579D1.0053C57F-C12579D1.0053DE76@transmode.se>
References: <1333119930-21129-1-git-send-email-kenth.eriksson@transmode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
To: Kenth Eriksson <kenth.eriksson@transmode.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1333119930-21129-1-git-send-email-kenth.eriksson@transmode.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

Kenth Eriksson <kenth.eriksson@transmode.com> wrote on 2012/03/30 17:05:30:
>
> After commit 178db7d3 devices are initialized as children of the bus master, not children of the bus masters parent device. The pdata pointer used in fsl_spi_chipselect must updated to reflect the changed initialization.
>
> Signed-off-by: Kenth Eriksson <kenth.eriksson@transmode.com>

Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
