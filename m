From: Rini van Zetten <rini@arvoo.nl>
Subject: Re: [PATCH][POWERPC] mpc83xx : allow SPI without cs.
Date: Thu, 11 Jun 2009 17:11:50 +0200
Message-ID: <4A311EB6.5060209@arvoo.nl>
References: <4A30CA1F.4000702@arvoo.nl>
	<7071E2AF-65ED-41C2-AFE7-06E9336619CB@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
To: Kumar Gala <galak@kernel.crashing.org>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <7071E2AF-65ED-41C2-AFE7-06E9336619CB@kernel.crashing.org>
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

excuse me for my ignorance, but which -mm tree do you mean and where can I find it.

Regards,
Rini

Kumar Gala schreef:
> 
> On Jun 11, 2009, at 4:10 AM, Rini van Zetten wrote:
> 
>> This patch adds the possibility to have a spi device without a cs.
>>
>> For example, the dts file should look something like this:
>>
>> spi-controller {
>>       gpios = <&pio1 1 0      /* cs0 */
>>                0              /* cs1, no GPIO */
>>                &pio2 2 0>;    /* cs2 */
>>
>>
>>
>> Signed-off-by: Rini van Zetten <rini@arvoo.nl>
>> ---
>> drivers/spi/spi_mpc83xx.c |   44 
>> +++++++++++++++++++++++---------------------
>> 1 files changed, 23 insertions(+), 21 deletions(-)
> 
> This patch needs to be respun against the -mm tree as a lot of other spi 
> patches are queued up there that will cause this patch to not merge 
> correctly.
> 
> - k

-- 
Rini van Zetten
Senior Software Engineer

-------------------------
ARVOO Engineering B.V.
Tasveld 13
3417 XS Montfoort
The Netherlands

E-mail : <mailto:rini@arvoo.com> Rini van Zetten

Web : www.arvoo.com
