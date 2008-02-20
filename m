From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: atmel_spi clock polarity
Date: Wed, 20 Feb 2008 18:50:45 +0900 (JST)
Message-ID: <20080220.185045.08317377.nemoto@toshiba-tops.co.jp>
References: <20080218153158.2ff8842a@dhcp-252-066.norway.atmel.com>
	<20080220.142109.11595419.nemoto@toshiba-tops.co.jp>
	<20080220103446.1621c81f@dhcp-252-066.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080220103446.1621c81f-STKoQgiEtS/cug01aK12UsGzbamoMwWuEvhb3Hwu1Ks@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 20 Feb 2008 10:34:46 +0100, Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> In that case, I think the best fix is to let NPCS0 stay selected
> permanently in MR and overwrite CSR0 with to the new slave's settings
> before asserting CS. But that's a more complicated change, and I don't
> know how it will affect the AT91RM9200 special cases.
> 
> So I suggest we merge your patch for 2.6.25, and try to optimize it
> for 2.6.26.

I absolutely agree.

> David, do you want me to pass on the patch with my signoff or just ask
> Andrew to add my Acked-by to the patch already in mm?

The patch in mm also lacks my Signed-off line.  I had thought Andrew
never take a patch without Signed-off line ;)

Should I resend my patch with my Signed-off and Haavard's Acked-by?

---
Atsushi Nemoto

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
