From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] spi/fsl_spi: Fix compile errors when building on ppc64
Date: Thu, 14 Oct 2010 09:41:57 -0500
Message-ID: <867777DE-D6E2-4448-9AD6-D201C77B2260@kernel.crashing.org>
References: <1287064547-8876-1-git-send-email-galak@kernel.crashing.org>
	<20101014141244.GA4312@angua.secretlab.ca>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20101014141244.GA4312@angua.secretlab.ca>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org


On Oct 14, 2010, at 9:12 AM, Grant Likely wrote:

> On Thu, Oct 14, 2010 at 08:55:47AM -0500, Kumar Gala wrote:
>> We get the following when building on ppc64 due to lack of include of
>> <asm/io.h>:
> 
> Is this an immediate problem (merge for .36), or is it a linux-next thing?
> 
> g.

.37 / next is fine.

- k
