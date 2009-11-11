From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/4] xilinx_spi: add a platform driver using the
	xilinx_spi common module.
Date: Wed, 11 Nov 2009 14:17:06 -0700
Message-ID: <fa686aa40911111317p66303b82g52246210a8e3cb5e@mail.gmail.com>
References: <4AFACCDE.7050802@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, dbrownell@users.sourceforge.net,
	John Linn <John.Linn@xilinx.com>, linuxppc-dev@ozlabs.org
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <4AFACCDE.7050802@mocean-labs.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 11, 2009 at 7:40 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> This patch adds in a platform device driver using the xilinx_spi common m=
odule.
>
> Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>

Pretty straight forward stuff.  Looks right to me.  (Except of course
for adding the pdata structure earlier in the series so that the
of_driver can use it too.

Thanks for all this work.

Cheers,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
