From: "Daniel Ribeiro" <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi: wait_rx_stall before
	deasserting CS on PIO mode
Date: Sun, 17 Aug 2008 19:59:55 -0300
Message-ID: <6669365c0808171559g30e111a9w7fcbd9a7a24f078e@mail.gmail.com>
References: <6669365c0808171553i3f64b667t18fcea589d94411a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_10086_19658198.1219013995853"
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6669365c0808171553i3f64b667t18fcea589d94411a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

------=_Part_10086_19658198.1219013995853
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As it seems gmail web interface will not allow me to send an inline
patch. Here is
an attached version. Sorry.

-- 
Daniel Ribeiro

------=_Part_10086_19658198.1219013995853
Content-Type: text/x-diff;
	name=wait_rx_stall-before-deasserting-CS-on-PIO-mode.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fk09z92d0
Content-Disposition: attachment;
	filename=wait_rx_stall-before-deasserting-CS-on-PIO-mode.patch

cHhhMnh4X3NwaTogd2FpdF9yeF9zdGFsbCBiZWZvcmUgZGVhc3NlcnRpbmcgQ1Mgb24gUElPIG1v
ZGUKClNpZ25lZC1vZmYtYnk6IERhbmllbCBSaWJlaXJvIDxkcnd5cm1AZ21haWwuY29tPgoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3B4YTJ4eF9zcGkuYyBiL2RyaXZlcnMvc3BpL3B4YTJ4eF9z
cGkuYwppbmRleCAwYzQ1MmM0Li40YTljMzRlIDEwMDY0NAotLS0gYS9kcml2ZXJzL3NwaS9weGEy
eHhfc3BpLmMKKysrIGIvZHJpdmVycy9zcGkvcHhhMnh4X3NwaS5jCkBAIC01OTMsNiArNTkzLDEw
IEBAIHN0YXRpYyB2b2lkIGludF90cmFuc2Zlcl9jb21wbGV0ZShzdHJ1Y3QgZHJpdmVyX2RhdGEg
KmRydl9kYXRhKQogewogCXZvaWQgX19pb21lbSAqcmVnID0gZHJ2X2RhdGEtPmlvYWRkcjsKIAor
CWlmICh3YWl0X3NzcF9yeF9zdGFsbChkcnZfZGF0YS0+aW9hZGRyKSA9PSAwKQorCQlkZXZfZXJy
KCZkcnZfZGF0YS0+cGRldi0+ZGV2LAorCQkJImludGVycnVwdF90cmFuc2Zlcjogc3NwIHJ4IHN0
YWxsIGZhaWxlZFxuIik7CisKIAkvKiBTdG9wIFNTUCAqLwogCXdyaXRlX1NTU1IoZHJ2X2RhdGEt
PmNsZWFyX3NyLCByZWcpOwogCXdyaXRlX1NTQ1IxKHJlYWRfU1NDUjEocmVnKSAmIH5kcnZfZGF0
YS0+aW50X2NyMSwgcmVnKTsK
------=_Part_10086_19658198.1219013995853
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
------=_Part_10086_19658198.1219013995853
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------=_Part_10086_19658198.1219013995853--
