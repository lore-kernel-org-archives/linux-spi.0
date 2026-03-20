Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA029ACD1;
	Fri, 20 Mar 2026 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998700; cv=none; b=Nquc6634TinBaxIfbZ4unJt6Kh0St7/X5FXmeL3DOgpJo0wSa3ObQlY+z7CnIbozzmHC6WgNZxk6oz85rJy9Hkk9+cknjDs6R8N5FhxQOMQePMa9VCj50AVtYpGOd84jjm4yzzrEDKhtAufoGRpWLWjw/8BUz19Iu6SXTggJIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998700; c=relaxed/simple;
	bh=iQzmSa7AYT0kNa3W+ZUG+N2GWnMiakPwuVmkeeJ+y2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwk7YsfUrR882K96r8ORKzTeKECLSdTQe9pB+JCPUXQXnJ5g3WZiI+r546xw3npcY+j4QC+yobUjeWWUzZRDAS8VL1V/CzcIpq3a2UbnmBm5ARAdrzM7Ab+aobjjdaHdGZqAhlclwpO/OFOXvPH53RvtzCvcbr87KhdNof/zfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAyMExVU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAyMExVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773998695; x=1805534695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iQzmSa7AYT0kNa3W+ZUG+N2GWnMiakPwuVmkeeJ+y2w=;
  b=oAyMExVUG7Lw7+yiNtfphFzDURCsiaBf4q4hjcP7mV+uePydWA/jxNj+
   UezfwfEoOYERT3+kOVit2disNOyHL5eoVAH196JishVSALpZwo3c2K9kx
   E2q4pMNgcJcUpcqzM2EJubHW9Hx2KUUP6eys9UBfnhHxi4PYqw2Tzvmku
   mShq+pRX+b8bTzdnugPs1oTTUuxAcbZThgyICc1EH1KPxNFzSUAqnNA7g
   DSppmRTu8cV2hOd0q/uMfr9wqSxKzQ3kkEIC0T/aiB22Fd508wFgmwo+6
   KXLVRxZ8cphj58KiyV9RB+pjJlDpcHKkG1cNXbskb3HevPtmGRkmJAEs4
   g==;
X-CSE-ConnectionGUID: HHeugBhyRGCC4PkigH88xQ==
X-CSE-MsgGUID: xrhCoXRURhC8DzHW8F60Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75199879"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75199879"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 02:24:54 -0700
X-CSE-ConnectionGUID: +kzKv5itTliNu1FZRwVbLQ==
X-CSE-MsgGUID: AsCz6WNbQbSxKQCnllbWQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223262706"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 20 Mar 2026 02:24:51 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3W5U-000000002Cb-3cKK;
	Fri, 20 Mar 2026 09:24:21 +0000
Date: Fri, 20 Mar 2026 17:23:05 +0800
From: kernel test robot <lkp@intel.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Marek Vasut <marex@nabladev.com>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH spi-next v2 03/11] spi: spi-fsl-lpspi: fsl_lpspi_probe():
 use FIELD_GET to decode Parameter register and add size check
Message-ID: <202603201743.2jFWu8hL-lkp@intel.com>
References: <20260319-spi-fsl-lpspi-cleanups-v2-3-02b56c5d44a8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-3-02b56c5d44a8@pengutronix.de>

Hi Marc,

kernel test robot noticed the following build errors:

[auto build test ERROR on b876ebf2c06042f78b2c9c47c53ffe54c7e480a2]

url:    https://github.com/intel-lab-lkp/linux/commits/Marc-Kleine-Budde/sp=
i-spi-fsl-lpspi-adapt-to-kernel-coding-style/20260320-022127
base:   b876ebf2c06042f78b2c9c47c53ffe54c7e480a2
patch link:    https://lore.kernel.org/r/20260319-spi-fsl-lpspi-cleanups-v2=
-3-02b56c5d44a8%40pengutronix.de
patch subject: [PATCH spi-next v2 03/11] spi: spi-fsl-lpspi: fsl_lpspi_prob=
e(): use FIELD_GET to decode Parameter register and add size check
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20260320/=
202603201743.2jFWu8hL-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20260320/202603201743.2jFWu8hL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603201743.2jFWu8hL-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/spi/spi-fsl-lpspi.c: In function 'fsl_lpspi_probe':
>> include/linux/compiler_types.h:706:45: error: call to '__compiletime_ass=
ert_467' declared with attribute error: min((( __builtin_constant_p(({ ({ (=
{ do { __attribute__((__noreturn__)) extern void __compiletime_assert_460(v=
oid) __attribute__((__error__("FIELD_MAX: " "mask is not constant"))); if (=
!(!(!__builtin_constant_p(((unsigned long)(((int)sizeof(struct {_Static_ass=
ert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((lon=
g)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (=
2))" " is true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1=
 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) <=
 ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof=
(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(uns=
igned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned lon=
g))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1=
)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*si=
zeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof=
(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2))))))))) __=
compiletime_assert_460(); } while (0); do { __attribute__((__noreturn__)) e=
xtern void __compiletime_assert_461(void) __attribute__((__error__("FIELD_M=
AX: " "mask is zero"))); if (!(!((((unsigned long)(((int)sizeof(struct {_St=
atic_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void=
 *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true=
((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(unsigned=
 long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long)=
)(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (=
8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( ty=
peof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsi=
gned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned l=
ong))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 =
<< (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < =
( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2))))=
)) =3D=3D 0))) __compiletime_assert_461(); } while (0); do { __attribute__(=
(__noreturn__)) extern void __compiletime_assert_462(void) __attribute__((_=
_error__("FIELD_MAX: " "value too large for the field"))); if (!(!(__builti=
n_constant_p(0ULL) ? ~((((unsigned long)(((int)sizeof(struct {_Static_asser=
t(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)=
((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2)=
)" " is true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 <=
< (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < (=
 typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(t=
ypeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsig=
ned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long)=
)1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))=
 < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*size=
of(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(u=
nsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) >> (__b=
uiltin_ffsll(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__built=
in_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2))=
 * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is tru=
e");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof=
(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(uns=
igned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsig=
ned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1=
))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*si=
zeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof=
(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(u=
nsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lon=
g))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1)) & (0 + (0ULL=
)) : 0))) __compiletime_assert_462(); } while (0); do { __attribute__((__no=
return__)) extern void __compiletime_assert_463(void) __attribute__((__erro=
r__("BUILD_BUG_ON failed: " "(((((unsigned long)(((int)sizeof(struct {_Stat=
ic_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *=
)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), \"const_true(=
(0) > (2))\" \" is true\");})) + (((typeof(unsigned long))((((typeof(unsign=
ed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lon=
g))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<=
 (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( =
typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(un=
signed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned=
 long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))=
1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) =
< ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2))=
)))) + (1ULL << (__builtin_ffsll(((unsigned long)(((int)sizeof(struct {_Sta=
tic_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void =
*)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), \"const_true=
((0) > (2))\" \" is true\");})) + (((typeof(unsigned long))((((typeof(unsig=
ned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lo=
ng))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <=
< (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < (=
 typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(u=
nsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigne=
d long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long)=
)1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))=
 < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)=
))))) - 1))) & (((((unsigned long)(((int)sizeof(struct {_Static_assert(!(__=
builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) >=
 (2)) * 0l)) : (int *)8))), (0) > (2), false)), \"const_true((0) > (2))\" \=
" is true\");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << =
(8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( t=
ypeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typ=
eof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigne=
d long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1=
 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) <=
 ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof=
(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(uns=
igned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) + (1ULL <=
< (__builtin_ffsll(((unsigned long)(((int)sizeof(struct {_Static_assert(!(_=
_builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) =
> (2)) * 0l)) : (int *)8))), (0) > (2), false)), \"const_true((0) > (2))\" =
\" is true\");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 <<=
 (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( =
typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(ty=
peof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsign=
ed long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))=
1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) =
< ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeo=
f(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(un=
signed long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1))) -=
 1)) !=3D 0"))); if (!(!((((((unsigned long)(((int)sizeof(struct {_Static_a=
ssert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((l=
ong)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) >=
 (2))" " is true");})) + (((typeof(unsigned long))((((typeof(unsigned long)=
)1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))=
 < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*size=
of(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(u=
nsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned l=
ong))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(=
-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*=
sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( type=
of(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) + (=
1ULL << (__builtin_ffsll(((unsigned long)(((int)sizeof(struct {_Static_asse=
rt(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long=
)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2=
))" " is true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 =
<< (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < =
( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(=
typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsi=
gned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long=
))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)=
) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*siz=
eof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(=
unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1)))=
 & (((((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choo=
se_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l))=
 : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");}))=
 + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof=
(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned l=
ong))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lon=
g)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) <=
< (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(ty=
peof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsign=
ed long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned=
 long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))=
)) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) + (1ULL << (__builtin_ffs=
ll(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_=
expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : =
(int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");})) + =
(((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(un=
signed long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long=
))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))=
 - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (=
0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeo=
f(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned =
long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lo=
ng)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) =
>> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1))) - 1)) !=3D 0))) __com=
piletime_assert_463(); } while (0); }); do { __attribute__((__noreturn__)) =
extern void __compiletime_assert_464(void) __attribute__((__error__("FIELD_=
MAX: " "type of reg too small for mask"))); if (!(!(((typeof( _Generic((((u=
nsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((=
sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *=
)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typ=
eof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned=
 long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))=
 - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 -=
 (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & (=
(typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsi=
gned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))=
1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -=
 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((s=
izeof(unsigned long) * 8) - 1 - (2)))))), char: (unsigned char)0, unsigned =
char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (uns=
igned short)0, signed short: (unsigned short)0, unsigned int: (unsigned int=
)0, signed int: (unsigned int)0, unsigned long: (unsigned long)0, signed lo=
ng: (unsigned long)0, unsigned long long: (unsigned long long)0, signed lon=
g long: (unsigned long long)0, default: (((unsigned long)(((int)sizeof(stru=
ct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ?=
 ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "con=
st_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(u=
nsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigne=
d long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long)=
)1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))=
 < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((type=
of(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(uns=
igned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned l=
ong))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(=
-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 -=
 (2)))))))))(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__built=
in_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2))=
 * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is tru=
e");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof=
(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(uns=
igned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsig=
ned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1=
))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*si=
zeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof=
(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(u=
nsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lon=
g))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2))))))) > ((typeof( _Gene=
ric((0ULL), char: (unsigned char)0, unsigned char: (unsigned char)0, signed=
 char: (unsigned char)0, unsigned short: (unsigned short)0, signed short: (=
unsigned short)0, unsigned int: (unsigned int)0, signed int: (unsigned int)=
0, unsigned long: (unsigned long)0, signed long: (unsigned long)0, unsigned=
 long long: (unsigned long long)0, signed long long: (unsigned long long)0,=
 default: (0ULL))))(~0ull))))) __compiletime_assert_464(); } while (0); });=
 (typeof(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_c=
hoose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0=
l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");=
})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typ=
eof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigne=
d long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned =
long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))=
) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof=
(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(uns=
igned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsig=
ned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1=
))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))))((((unsigned long)(((i=
nt)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=
=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2=
), false)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned lo=
ng))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (=
((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeo=
f(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsi=
gned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigne=
d long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1=
 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((t=
ypeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(=
unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned =
long) * 8) - 1 - (2)))))) >> (__builtin_ffsll(((unsigned long)(((int)sizeof=
(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(=
*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)),=
 "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typ=
eof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(un=
signed long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned =
long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))=
(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))(((=
(typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeo=
f(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsig=
ned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lo=
ng))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) =
- 1 - (2)))))) - 1)); }) + 1) ? ((({ ({ ({ do { __attribute__((__noreturn__=
)) extern void __compiletime_assert_460(void) __attribute__((__error__("FIE=
LD_MAX: " "mask is not constant"))); if (!(!(!__builtin_constant_p(((unsign=
ed long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeo=
f(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8)))=
, (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(u=
nsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long=
)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1)=
 + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((t=
ypeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((type=
of(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned =
long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) =
- 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - =
(((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof=
(unsigned long) * 8) - 1 - (2))))))))) __compiletime_assert_460(); } while =
(0); do { __attribute__((__noreturn__)) extern void __compiletime_assert_46=
1(void) __attribute__((__error__("FIELD_MAX: " "mask is zero"))); if (!(!((=
((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_exp=
r((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (in=
t *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((=
typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsig=
ned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1=
))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - =
1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) =
& ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(u=
nsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lon=
g))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)=
) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> =
((sizeof(unsigned long) * 8) - 1 - (2)))))) =3D=3D 0))) __compiletime_asser=
t_461(); } while (0); do { __attribute__((__noreturn__)) extern void __comp=
iletime_assert_462(void) __attribute__((__error__("FIELD_MAX: " "value too =
large for the field"))); if (!(!(__builtin_constant_p(0ULL) ? ~((((unsigned=
 long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(=
int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), =
(0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(uns=
igned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))=
 - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) +=
 ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typ=
eof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof=
(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lo=
ng)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - =
1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - ((=
(typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(u=
nsigned long) * 8) - 1 - (2)))))) >> (__builtin_ffsll(((unsigned long)(((in=
t)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D=
 sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), =
false)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long)=
)((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((t=
ypeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(u=
nsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigne=
d long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned l=
ong))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - =
(((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((type=
of(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(uns=
igned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned lon=
g) * 8) - 1 - (2)))))) - 1)) & (0 + (0ULL)) : 0))) __compiletime_assert_462=
(); } while (0); do { __attribute__((__noreturn__)) extern void __compileti=
me_assert_463(void) __attribute__((__error__("BUILD_BUG_ON failed: " "(((((=
unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr(=
(sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int =
*)8))), (0) > (2), false)), \"const_true((0) > (2))\" \" is true\");})) + (=
((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(uns=
igned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long)=
)1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) =
- 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0=
) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof=
(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned l=
ong))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lon=
g)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >=
> ((sizeof(unsigned long) * 8) - 1 - (2)))))) + (1ULL << (__builtin_ffsll((=
(unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr=
((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int=
 *)8))), (0) > (2), false)), \"const_true((0) > (2))\" \" is true\");})) + =
(((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(un=
signed long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long=
))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))=
 - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (=
0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeo=
f(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned =
long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lo=
ng)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) =
>> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1))) & (((((unsigned long)=
(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =
=3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) >=
 (2), false)), \"const_true((0) > (2))\" \" is true\");})) + (((typeof(unsi=
gned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) =
- 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + =
((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((type=
of(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(=
unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lon=
g)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1=
) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((=
typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(un=
signed long) * 8) - 1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsigned lon=
g)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int)=
 =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) =
> (2), false)), \"const_true((0) > (2))\" \" is true\");})) + (((typeof(uns=
igned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))=
 - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) +=
 ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typ=
eof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof=
(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lo=
ng)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - =
1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - ((=
(typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(u=
nsigned long) * 8) - 1 - (2)))))) - 1))) - 1)) !=3D 0"))); if (!(!((((((uns=
igned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((si=
zeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8=
))), (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeo=
f(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned l=
ong)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -=
 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (=
((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((t=
ypeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsign=
ed long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)=
)) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1=
 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((siz=
eof(unsigned long) * 8) - 1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsign=
ed long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeo=
f(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8)))=
, (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(u=
nsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long=
)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1)=
 + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((t=
ypeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((type=
of(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned =
long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) =
- 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - =
(((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof=
(unsigned long) * 8) - 1 - (2)))))) - 1))) & (((((unsigned long)(((int)size=
of(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeo=
f(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)=
), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((t=
ypeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(=
unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigne=
d long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long=
))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))(=
(((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typ=
eof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(uns=
igned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned =
long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8=
) - 1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsigned long)(((int)sizeof(=
struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*=
(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), =
"const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((type=
of(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(uns=
igned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned l=
ong))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(=
-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((=
typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof=
(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsign=
ed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lon=
g))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) -=
 1 - (2)))))) - 1))) - 1)) !=3D 0))) __compiletime_assert_463(); } while (0=
); }); do { __attribute__((__noreturn__)) extern void __compiletime_assert_=
464(void) __attribute__((__error__("FIELD_MAX: " "type of reg too small for=
 mask"))); if (!(!(((typeof( _Generic((((unsigned long)(((int)sizeof(struct=
 {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? (=
(void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const=
_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(uns=
igned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned =
long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1=
 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) <=
 ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof=
(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsig=
ned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned lon=
g))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1=
)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (=
2)))))), char: (unsigned char)0, unsigned char: (unsigned char)0, signed ch=
ar: (unsigned char)0, unsigned short: (unsigned short)0, signed short: (uns=
igned short)0, unsigned int: (unsigned int)0, signed int: (unsigned int)0, =
unsigned long: (unsigned long)0, signed long: (unsigned long)0, unsigned lo=
ng long: (unsigned long long)0, signed long long: (unsigned long long)0, de=
fault: (((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_ch=
oose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l=
)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");}=
)) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(type=
of(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned=
 long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned l=
ong)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))=
 << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(=
typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsi=
gned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsign=
ed long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)=
)))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))))))(((unsigned long)(((i=
nt)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=
=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2=
), false)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned lo=
ng))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (=
((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeo=
f(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsi=
gned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigne=
d long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1=
 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((t=
ypeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(=
unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned =
long) * 8) - 1 - (2))))))) > ((typeof( _Generic((0ULL), char: (unsigned cha=
r)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsign=
ed short: (unsigned short)0, signed short: (unsigned short)0, unsigned int:=
 (unsigned int)0, signed int: (unsigned int)0, unsigned long: (unsigned lon=
g)0, signed long: (unsigned long)0, unsigned long long: (unsigned long long=
)0, signed long long: (unsigned long long)0, default: (0ULL))))(~0ull))))) =
__compiletime_assert_464(); } while (0); }); (typeof(((unsigned long)(((int=
)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D =
sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), f=
alse)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))=
((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((ty=
peof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(un=
signed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned=
 long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned lo=
ng))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (=
((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeo=
f(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsi=
gned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long=
) * 8) - 1 - (2)))))))((((unsigned long)(((int)sizeof(struct {_Static_asser=
t(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)=
((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2)=
)" " is true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 <=
< (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < (=
 typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(t=
ypeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsig=
ned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long)=
)1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))=
 < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*size=
of(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(u=
nsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) >> (__b=
uiltin_ffsll(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__built=
in_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2))=
 * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is tru=
e");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof=
(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(uns=
igned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsig=
ned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1=
))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*si=
zeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof=
(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(u=
nsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lon=
g))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1)); }) + 1) < 2=
 ? 0 : 63 - __builtin_clzll(({ ({ ({ do { __attribute__((__noreturn__)) ext=
ern void __compiletime_assert_460(void) __attribute__((__error__("FIELD_MAX=
: " "mask is not constant"))); if (!(!(!__builtin_constant_p(((unsigned lon=
g)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int)=
 =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) =
> (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigne=
d long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1=
 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((t=
ypeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(=
unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(uns=
igned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))=
 - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) +=
 ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typ=
eof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsig=
ned long) * 8) - 1 - (2))))))))) __compiletime_assert_460(); } while (0); d=
o { __attribute__((__noreturn__)) extern void __compiletime_assert_461(void=
) __attribute__((__error__("FIELD_MAX: " "mask is zero"))); if (!(!((((unsi=
gned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((siz=
eof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8)=
)), (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof=
(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lo=
ng)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - =
1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - ((=
(typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((ty=
peof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigne=
d long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))=
) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 =
- (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((size=
of(unsigned long) * 8) - 1 - (2)))))) =3D=3D 0))) __compiletime_assert_461(=
); } while (0); do { __attribute__((__noreturn__)) extern void __compiletim=
e_assert_462(void) __attribute__((__error__("FIELD_MAX: " "value too large =
for the field"))); if (!(!(__builtin_constant_p(0ULL) ? ~((((unsigned long)=
(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =
=3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) >=
 (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned=
 long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 =
- (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((ty=
peof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(u=
nsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsi=
gned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) =
- 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + =
((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((type=
of(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsign=
ed long) * 8) - 1 - (2)))))) >> (__builtin_ffsll(((unsigned long)(((int)siz=
eof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D size=
of(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false=
)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((=
typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof=
(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsign=
ed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lon=
g))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))=
((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((ty=
peof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(un=
signed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned=
 long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * =
8) - 1 - (2)))))) - 1)) & (0 + (0ULL)) : 0))) __compiletime_assert_462(); }=
 while (0); do { __attribute__((__noreturn__)) extern void __compiletime_as=
sert_463(void) __attribute__((__error__("BUILD_BUG_ON failed: " "(((((unsig=
ned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((size=
of(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))=
), (0) > (2), false)), \"const_true((0) > (2))\" \" is true\");})) + (((typ=
eof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned=
 long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))=
 - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 -=
 (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & (=
(typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsi=
gned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))=
1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -=
 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((s=
izeof(unsigned long) * 8) - 1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsi=
gned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((siz=
eof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8)=
)), (0) > (2), false)), \"const_true((0) > (2))\" \" is true\");})) + (((ty=
peof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigne=
d long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))=
) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 =
- (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & =
((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(uns=
igned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long)=
)1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) =
- 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((=
sizeof(unsigned long) * 8) - 1 - (2)))))) - 1))) & (((((unsigned long)(((in=
t)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D=
 sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), =
false)), \"const_true((0) > (2))\" \" is true\");})) + (((typeof(unsigned l=
ong))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - =
(((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((type=
of(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(uns=
igned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsign=
ed long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - =
1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((=
typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof=
(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned=
 long) * 8) - 1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsigned long)(((i=
nt)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=
=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2=
), false)), \"const_true((0) > (2))\" \" is true\");})) + (((typeof(unsigne=
d long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1=
 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((t=
ypeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(=
unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(uns=
igned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))=
 - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) +=
 ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typ=
eof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsig=
ned long) * 8) - 1 - (2)))))) - 1))) - 1)) !=3D 0"))); if (!(!((((((unsigne=
d long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof=
(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))),=
 (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(un=
signed long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)=
) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) =
+ ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((ty=
peof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeo=
f(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned l=
ong)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -=
 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (=
((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(=
unsigned long) * 8) - 1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsigned l=
ong)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(in=
t) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0=
) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(unsig=
ned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -=
 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + (=
(typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeo=
f(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(u=
nsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long=
)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1)=
 + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((t=
ypeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(uns=
igned long) * 8) - 1 - (2)))))) - 1))) & (((((unsigned long)(((int)sizeof(s=
truct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(=
8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "=
const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeo=
f(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsi=
gned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned lo=
ng))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-=
1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((t=
ypeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(=
unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigne=
d long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long=
))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - =
1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsigned long)(((int)sizeof(stru=
ct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ?=
 ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "con=
st_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(u=
nsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigne=
d long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long)=
)1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))=
 < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((type=
of(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(uns=
igned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned l=
ong))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(=
-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 -=
 (2)))))) - 1))) - 1)) !=3D 0))) __compiletime_assert_463(); } while (0); }=
); do { __attribute__((__noreturn__)) extern void __compiletime_assert_464(=
void) __attribute__((__error__("FIELD_MAX: " "type of reg too small for mas=
k"))); if (!(!(((typeof( _Generic((((unsigned long)(((int)sizeof(struct {_S=
tatic_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((voi=
d *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_tru=
e((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(unsigne=
d long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long=
))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << =
(8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( t=
ypeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(uns=
igned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned =
long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1=
 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) <=
 ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))=
))), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: =
(unsigned char)0, unsigned short: (unsigned short)0, signed short: (unsigne=
d short)0, unsigned int: (unsigned int)0, signed int: (unsigned int)0, unsi=
gned long: (unsigned long)0, signed long: (unsigned long)0, unsigned long l=
ong: (unsigned long long)0, signed long long: (unsigned long long)0, defaul=
t: (((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose=
_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) :=
 (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");})) +=
 (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(u=
nsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lon=
g))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)=
) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << =
(0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(type=
of(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned=
 long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned l=
ong)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))=
 >> ((sizeof(unsigned long) * 8) - 1 - (2)))))))))(((unsigned long)(((int)s=
izeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D si=
zeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), fal=
se)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((=
((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((type=
of(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsi=
gned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned l=
ong))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long=
))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((=
typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(=
unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsign=
ed long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) =
* 8) - 1 - (2))))))) > ((typeof( _Generic((0ULL), char: (unsigned char)0, u=
nsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned sho=
rt: (unsigned short)0, signed short: (unsigned short)0, unsigned int: (unsi=
gned int)0, signed int: (unsigned int)0, unsigned long: (unsigned long)0, s=
igned long: (unsigned long)0, unsigned long long: (unsigned long long)0, si=
gned long long: (unsigned long long)0, default: (0ULL))))(~0ull))))) __comp=
iletime_assert_464(); } while (0); }); (typeof(((unsigned long)(((int)sizeo=
f(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof=
(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false))=
, "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((ty=
peof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(u=
nsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned=
 long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long)=
)(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((=
((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((type=
of(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsi=
gned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned l=
ong))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8)=
 - 1 - (2)))))))((((unsigned long)(((int)sizeof(struct {_Static_assert(!(__=
builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) >=
 (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " i=
s true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*s=
izeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeo=
f(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(=
unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lo=
ng))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << =
(8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( t=
ypeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typ=
eof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigne=
d long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) >> (__builtin=
_ffsll(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_cho=
ose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)=
) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");})=
) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeo=
f(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned =
long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lo=
ng)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) =
<< (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(t=
ypeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsig=
ned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigne=
d long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))=
))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1)); }) + 1)) : (sizeo=
f(({ ({ ({ do { __attribute__((__noreturn__)) extern void __compiletime_ass=
ert_460(void) __attribute__((__error__("FIELD_MAX: " "mask is not constant"=
))); if (!(!(!__builtin_constant_p(((unsigned long)(((int)sizeof(struct {_S=
tatic_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((voi=
d *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_tru=
e((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(unsigne=
d long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long=
))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << =
(8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( t=
ypeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(uns=
igned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned =
long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1=
 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) <=
 ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))=
)))))) __compiletime_assert_460(); } while (0); do { __attribute__((__noret=
urn__)) extern void __compiletime_assert_461(void) __attribute__((__error__=
("FIELD_MAX: " "mask is zero"))); if (!(!((((unsigned long)(((int)sizeof(st=
ruct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8=
 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "c=
onst_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof=
(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsig=
ned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned lon=
g))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1=
)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((ty=
peof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(u=
nsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned=
 long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long)=
)(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1=
 - (2)))))) =3D=3D 0))) __compiletime_assert_461(); } while (0); do { __att=
ribute__((__noreturn__)) extern void __compiletime_assert_462(void) __attri=
bute__((__error__("FIELD_MAX: " "value too large for the field"))); if (!(!=
(__builtin_constant_p(0ULL) ? ~((((unsigned long)(((int)sizeof(struct {_Sta=
tic_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void =
*)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true(=
(0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(unsigned =
long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))=
(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8=
*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typ=
eof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsig=
ned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lo=
ng))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <=
< (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < (=
 typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))=
) >> (__builtin_ffsll(((unsigned long)(((int)sizeof(struct {_Static_assert(=
!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((=
0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))"=
 " is true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << =
(8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( t=
ypeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typ=
eof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigne=
d long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1=
 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) <=
 ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof=
(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(uns=
igned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1)) & (=
0 + (0ULL)) : 0))) __compiletime_assert_462(); } while (0); do { __attribut=
e__((__noreturn__)) extern void __compiletime_assert_463(void) __attribute_=
_((__error__("BUILD_BUG_ON failed: " "(((((unsigned long)(((int)sizeof(stru=
ct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ?=
 ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), \"co=
nst_true((0) > (2))\" \" is true\");})) + (((typeof(unsigned long))((((type=
of(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(uns=
igned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned l=
ong))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(=
-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((=
typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof=
(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsign=
ed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lon=
g))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) -=
 1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsigned long)(((int)sizeof(str=
uct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 =
? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), \"c=
onst_true((0) > (2))\" \" is true\");})) + (((typeof(unsigned long))((((typ=
eof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(un=
signed long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned =
long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))=
(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))(((=
(typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeo=
f(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsig=
ned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lo=
ng))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) =
- 1 - (2)))))) - 1))) & (((((unsigned long)(((int)sizeof(struct {_Static_as=
sert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((lo=
ng)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), \"const_true((0) >=
 (2))\" \" is true\");})) + (((typeof(unsigned long))((((typeof(unsigned lo=
ng))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-=
1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*s=
izeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeo=
f(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigne=
d long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long=
))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << =
(8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( t=
ypeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) =
+ (1ULL << (__builtin_ffsll(((unsigned long)(((int)sizeof(struct {_Static_a=
ssert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((l=
ong)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), \"const_true((0) =
> (2))\" \" is true\");})) + (((typeof(unsigned long))((((typeof(unsigned l=
ong))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(=
-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*=
sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( type=
of(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsign=
ed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lon=
g))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<=
 (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( =
typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2))))))=
 - 1))) - 1)) !=3D 0"))); if (!(!((((((unsigned long)(((int)sizeof(struct {=
_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((v=
oid *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_t=
rue((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(unsig=
ned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lo=
ng))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <=
< (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < (=
 typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(u=
nsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigne=
d long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long)=
)1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))=
 < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)=
))))) + (1ULL << (__builtin_ffsll(((unsigned long)(((int)sizeof(struct {_St=
atic_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void=
 *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true=
((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(unsigned=
 long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long)=
)(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (=
8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( ty=
peof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsi=
gned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned l=
ong))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 =
<< (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < =
( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2))))=
)) - 1))) & (((((unsigned long)(((int)sizeof(struct {_Static_assert(!(__bui=
ltin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2=
)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is t=
rue");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*size=
of(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(u=
nsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(uns=
igned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long)=
)1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*=
sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( type=
of(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof=
(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned l=
ong))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) + (1ULL << (__bu=
iltin_ffsll(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builti=
n_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) =
* 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true=
");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(=
typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsi=
gned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsign=
ed long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)=
)))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*siz=
eof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(=
unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(un=
signed long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long=
))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1))) - 1)) !=3D 0=
))) __compiletime_assert_463(); } while (0); }); do { __attribute__((__nore=
turn__)) extern void __compiletime_assert_464(void) __attribute__((__error_=
_("FIELD_MAX: " "type of reg too small for mask"))); if (!(!(((typeof( _Gen=
eric((((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choo=
se_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l))=
 : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");}))=
 + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof=
(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned l=
ong))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lon=
g)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) <=
< (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(ty=
peof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsign=
ed long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned=
 long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))=
)) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))), char: (unsigned char)0, =
unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned sh=
ort: (unsigned short)0, signed short: (unsigned short)0, unsigned int: (uns=
igned int)0, signed int: (unsigned int)0, unsigned long: (unsigned long)0, =
signed long: (unsigned long)0, unsigned long long: (unsigned long long)0, s=
igned long long: (unsigned long long)0, default: (((unsigned long)(((int)si=
zeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D siz=
eof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), fals=
e)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))(((=
(typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeo=
f(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsig=
ned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lo=
ng))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long)=
)((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((t=
ypeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(u=
nsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigne=
d long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) *=
 8) - 1 - (2)))))))))(((unsigned long)(((int)sizeof(struct {_Static_assert(=
!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((=
0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))"=
 " is true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << =
(8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( t=
ypeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typ=
eof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigne=
d long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1=
 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) <=
 ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof=
(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(uns=
igned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2))))))) > ((type=
of( _Generic((0ULL), char: (unsigned char)0, unsigned char: (unsigned char)=
0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, signed=
 short: (unsigned short)0, unsigned int: (unsigned int)0, signed int: (unsi=
gned int)0, unsigned long: (unsigned long)0, signed long: (unsigned long)0,=
 unsigned long long: (unsigned long long)0, signed long long: (unsigned lon=
g long)0, default: (0ULL))))(~0ull))))) __compiletime_assert_464(); } while=
 (0); }); (typeof(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__=
builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) >=
 (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " i=
s true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*s=
izeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeo=
f(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(=
unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lo=
ng))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << =
(8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( t=
ypeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typ=
eof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigne=
d long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))))((((unsigned =
long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(i=
nt) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (=
0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(unsi=
gned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) =
- 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + =
((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((type=
of(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(=
unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lon=
g)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1=
) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((=
typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(un=
signed long) * 8) - 1 - (2)))))) >> (__builtin_ffsll(((unsigned long)(((int=
)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D =
sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), f=
alse)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))=
((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((ty=
peof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(un=
signed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned=
 long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned lo=
ng))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (=
((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeo=
f(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsi=
gned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long=
) * 8) - 1 - (2)))))) - 1)); }) + 1) <=3D 4) ? __ilog2_u32(({ ({ ({ do { __=
attribute__((__noreturn__)) extern void __compiletime_assert_460(void) __at=
tribute__((__error__("FIELD_MAX: " "mask is not constant"))); if (!(!(!__bu=
iltin_constant_p(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__b=
uiltin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > =
(2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is=
 true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*si=
zeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof=
(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(u=
nsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lon=
g))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (=
8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( ty=
peof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(type=
of(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned=
 long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2))))))))) __compileti=
me_assert_460(); } while (0); do { __attribute__((__noreturn__)) extern voi=
d __compiletime_assert_461(void) __attribute__((__error__("FIELD_MAX: " "ma=
sk is zero"))); if (!(!((((unsigned long)(((int)sizeof(struct {_Static_asse=
rt(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long=
)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2=
))" " is true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 =
<< (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < =
( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(=
typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsi=
gned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long=
))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)=
) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*siz=
eof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(=
unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) =3D=3D=
 0))) __compiletime_assert_461(); } while (0); do { __attribute__((__noretu=
rn__)) extern void __compiletime_assert_462(void) __attribute__((__error__(=
"FIELD_MAX: " "value too large for the field"))); if (!(!(__builtin_constan=
t_p(0ULL) ? ~((((unsigned long)(((int)sizeof(struct {_Static_assert(!(__bui=
ltin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2=
)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is t=
rue");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*size=
of(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(u=
nsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(uns=
igned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long)=
)1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*=
sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( type=
of(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof=
(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned l=
ong))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) >> (__builtin_ff=
sll(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose=
_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) :=
 (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");})) +=
 (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(u=
nsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lon=
g))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)=
) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << =
(0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(type=
of(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned=
 long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned l=
ong)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))=
 >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1)) & (0 + (0ULL)) : 0)))=
 __compiletime_assert_462(); } while (0); do { __attribute__((__noreturn__)=
) extern void __compiletime_assert_463(void) __attribute__((__error__("BUIL=
D_BUG_ON failed: " "(((((unsigned long)(((int)sizeof(struct {_Static_assert=
(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(=
(0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), \"const_true((0) > (2)=
)\" \" is true\");})) + (((typeof(unsigned long))((((typeof(unsigned long))=
1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) =
< ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeo=
f(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(un=
signed long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned lo=
ng))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-=
1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*s=
izeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeo=
f(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) + (1=
ULL << (__builtin_ffsll(((unsigned long)(((int)sizeof(struct {_Static_asser=
t(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)=
((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), \"const_true((0) > (2=
))\" \" is true\");})) + (((typeof(unsigned long))((((typeof(unsigned long)=
)1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))=
 < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*size=
of(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(u=
nsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned l=
ong))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(=
-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*=
sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( type=
of(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1=
))) & (((((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_c=
hoose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0=
l)) : (int *)8))), (0) > (2), false)), \"const_true((0) > (2))\" \" is true=
\");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof=
(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(uns=
igned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsig=
ned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1=
))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*si=
zeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof=
(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(u=
nsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lon=
g))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) + (1ULL << (__buil=
tin_ffsll(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_=
choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * =
0l)) : (int *)8))), (0) > (2), false)), \"const_true((0) > (2))\" \" is tru=
e\");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeo=
f(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(un=
signed long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsi=
gned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))=
1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*s=
izeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeo=
f(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(=
unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lo=
ng))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1))) - 1)) !=3D=
 0"))); if (!(!((((((unsigned long)(((int)sizeof(struct {_Static_assert(!(_=
_builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) =
> (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " =
is true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*=
sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( type=
of(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof=
(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned l=
ong))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 <<=
 (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( =
typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(ty=
peof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsign=
ed long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) + (1ULL << (=
__builtin_ffsll(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__bu=
iltin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (=
2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is =
true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*siz=
eof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(=
unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(un=
signed long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long=
))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8=
*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typ=
eof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeo=
f(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned =
long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1))) & (((((u=
nsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((=
sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *=
)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typ=
eof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned=
 long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))=
 - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 -=
 (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & (=
(typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsi=
gned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))=
1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -=
 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((s=
izeof(unsigned long) * 8) - 1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsi=
gned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((siz=
eof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8)=
)), (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof=
(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lo=
ng)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - =
1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - ((=
(typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((ty=
peof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigne=
d long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))=
) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 =
- (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((size=
of(unsigned long) * 8) - 1 - (2)))))) - 1))) - 1)) !=3D 0))) __compiletime_=
assert_463(); } while (0); }); do { __attribute__((__noreturn__)) extern vo=
id __compiletime_assert_464(void) __attribute__((__error__("FIELD_MAX: " "t=
ype of reg too small for mask"))); if (!(!(((typeof( _Generic((((unsigned l=
ong)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(in=
t) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0=
) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(unsig=
ned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -=
 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + (=
(typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeo=
f(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(u=
nsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long=
)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1)=
 + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((t=
ypeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(uns=
igned long) * 8) - 1 - (2)))))), char: (unsigned char)0, unsigned char: (un=
signed char)0, signed char: (unsigned char)0, unsigned short: (unsigned sho=
rt)0, signed short: (unsigned short)0, unsigned int: (unsigned int)0, signe=
d int: (unsigned int)0, unsigned long: (unsigned long)0, signed long: (unsi=
gned long)0, unsigned long long: (unsigned long long)0, signed long long: (=
unsigned long long)0, default: (((unsigned long)(((int)sizeof(struct {_Stat=
ic_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *=
)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((=
0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(unsigned l=
ong))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(=
-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*=
sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( type=
of(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsign=
ed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lon=
g))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 <<=
 (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( =
typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2))))))=
)))(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose=
_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) :=
 (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");})) +=
 (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(u=
nsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lon=
g))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)=
) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << =
(0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(type=
of(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned=
 long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned l=
ong)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))=
 >> ((sizeof(unsigned long) * 8) - 1 - (2))))))) > ((typeof( _Generic((0ULL=
), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (u=
nsigned char)0, unsigned short: (unsigned short)0, signed short: (unsigned =
short)0, unsigned int: (unsigned int)0, signed int: (unsigned int)0, unsign=
ed long: (unsigned long)0, signed long: (unsigned long)0, unsigned long lon=
g: (unsigned long long)0, signed long long: (unsigned long long)0, default:=
 (0ULL))))(~0ull))))) __compiletime_assert_464(); } while (0); }); (typeof(=
((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_exp=
r((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (in=
t *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((=
typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsig=
ned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1=
))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - =
1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) =
& ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(u=
nsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lon=
g))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)=
) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> =
((sizeof(unsigned long) * 8) - 1 - (2)))))))((((unsigned long)(((int)sizeof=
(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(=
*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)),=
 "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typ=
eof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(un=
signed long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned =
long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))=
(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))(((=
(typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeo=
f(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsig=
ned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lo=
ng))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) =
- 1 - (2)))))) >> (__builtin_ffsll(((unsigned long)(((int)sizeof(struct {_S=
tatic_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((voi=
d *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_tru=
e((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(unsigne=
d long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long=
))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << =
(8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( t=
ypeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(uns=
igned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned =
long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1=
 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) <=
 ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))=
))) - 1)); }) + 1) : __ilog2_u64(({ ({ ({ do { __attribute__((__noreturn__)=
) extern void __compiletime_assert_460(void) __attribute__((__error__("FIEL=
D_MAX: " "mask is not constant"))); if (!(!(!__builtin_constant_p(((unsigne=
d long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof=
(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))),=
 (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(un=
signed long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)=
) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) =
+ ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((ty=
peof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeo=
f(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned l=
ong)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -=
 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (=
((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(=
unsigned long) * 8) - 1 - (2))))))))) __compiletime_assert_460(); } while (=
0); do { __attribute__((__noreturn__)) extern void __compiletime_assert_461=
(void) __attribute__((__error__("FIELD_MAX: " "mask is zero"))); if (!(!(((=
(unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr=
((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int=
 *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((t=
ypeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsign=
ed long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)=
)) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1=
 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) &=
 ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(un=
signed long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long=
))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))=
 - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> (=
(sizeof(unsigned long) * 8) - 1 - (2)))))) =3D=3D 0))) __compiletime_assert=
_461(); } while (0); do { __attribute__((__noreturn__)) extern void __compi=
letime_assert_462(void) __attribute__((__error__("FIELD_MAX: " "value too l=
arge for the field"))); if (!(!(__builtin_constant_p(0ULL) ? ~((((unsigned =
long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(i=
nt) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (=
0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(unsi=
gned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) =
- 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + =
((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((type=
of(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(=
unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lon=
g)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1=
) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((=
typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(un=
signed long) * 8) - 1 - (2)))))) >> (__builtin_ffsll(((unsigned long)(((int=
)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D =
sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), f=
alse)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))=
((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((ty=
peof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(un=
signed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned=
 long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned lo=
ng))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (=
((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeo=
f(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsi=
gned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long=
) * 8) - 1 - (2)))))) - 1)) & (0 + (0ULL)) : 0))) __compiletime_assert_462(=
); } while (0); do { __attribute__((__noreturn__)) extern void __compiletim=
e_assert_463(void) __attribute__((__error__("BUILD_BUG_ON failed: " "(((((u=
nsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((=
sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *=
)8))), (0) > (2), false)), \"const_true((0) > (2))\" \" is true\");})) + ((=
(typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsi=
gned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))=
1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) -=
 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0)=
 & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(=
unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lo=
ng))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long=
)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >>=
 ((sizeof(unsigned long) * 8) - 1 - (2)))))) + (1ULL << (__builtin_ffsll(((=
unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr(=
(sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int =
*)8))), (0) > (2), false)), \"const_true((0) > (2))\" \" is true\");})) + (=
((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(uns=
igned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long)=
)1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) =
- 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0=
) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof=
(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned l=
ong))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lon=
g)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >=
> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1))) & (((((unsigned long)(=
((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =
=3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) >=
 (2), false)), \"const_true((0) > (2))\" \" is true\");})) + (((typeof(unsi=
gned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) =
- 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + =
((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((type=
of(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(=
unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lon=
g)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1=
) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((=
typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(un=
signed long) * 8) - 1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsigned lon=
g)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int)=
 =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) =
> (2), false)), \"const_true((0) > (2))\" \" is true\");})) + (((typeof(uns=
igned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long))=
 - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) +=
 ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typ=
eof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof=
(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned lo=
ng)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - =
1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - ((=
(typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(u=
nsigned long) * 8) - 1 - (2)))))) - 1))) - 1)) !=3D 0"))); if (!(!((((((uns=
igned long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((si=
zeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8=
))), (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeo=
f(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned l=
ong)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) -=
 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (=
((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((t=
ypeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsign=
ed long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)=
)) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1=
 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((siz=
eof(unsigned long) * 8) - 1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsign=
ed long)(((int)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeo=
f(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8)))=
, (0) > (2), false)), "const_true((0) > (2))" " is true");})) + (((typeof(u=
nsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long=
)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1)=
 + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((t=
ypeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((type=
of(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned =
long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) =
- 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - =
(((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof=
(unsigned long) * 8) - 1 - (2)))))) - 1))) & (((((unsigned long)(((int)size=
of(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeo=
f(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)=
), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((t=
ypeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(=
unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigne=
d long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long=
))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))(=
(((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typ=
eof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(uns=
igned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned =
long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8=
) - 1 - (2)))))) + (1ULL << (__builtin_ffsll(((unsigned long)(((int)sizeof(=
struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*=
(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), =
"const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((type=
of(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(uns=
igned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned l=
ong))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(=
-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((=
typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof=
(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsign=
ed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned lon=
g))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) -=
 1 - (2)))))) - 1))) - 1)) !=3D 0))) __compiletime_assert_463(); } while (0=
); }); do { __attribute__((__noreturn__)) extern void __compiletime_assert_=
464(void) __attribute__((__error__("FIELD_MAX: " "type of reg too small for=
 mask"))); if (!(!(((typeof( _Generic((((unsigned long)(((int)sizeof(struct=
 {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? (=
(void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const=
_true((0) > (2))" " is true");})) + (((typeof(unsigned long))((((typeof(uns=
igned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned =
long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1=
 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) <=
 ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned long))((((typeof=
(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsig=
ned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned lon=
g))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1=
)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (=
2)))))), char: (unsigned char)0, unsigned char: (unsigned char)0, signed ch=
ar: (unsigned char)0, unsigned short: (unsigned short)0, signed short: (uns=
igned short)0, unsigned int: (unsigned int)0, signed int: (unsigned int)0, =
unsigned long: (unsigned long)0, signed long: (unsigned long)0, unsigned lo=
ng long: (unsigned long long)0, signed long long: (unsigned long long)0, de=
fault: (((unsigned long)(((int)sizeof(struct {_Static_assert(!(__builtin_ch=
oose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l=
)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is true");}=
)) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(type=
of(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned=
 long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned l=
ong)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)))))=
 << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof(=
typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsi=
gned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsign=
ed long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1)=
)))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))))))(((unsigned long)(((i=
nt)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=
=3D sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2=
), false)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned lo=
ng))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (=
((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeo=
f(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsi=
gned long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigne=
d long))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1=
 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((t=
ypeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(=
unsigned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned =
long) * 8) - 1 - (2))))))) > ((typeof( _Generic((0ULL), char: (unsigned cha=
r)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsign=
ed short: (unsigned short)0, signed short: (unsigned short)0, unsigned int:=
 (unsigned int)0, signed int: (unsigned int)0, unsigned long: (unsigned lon=
g)0, signed long: (unsigned long)0, unsigned long long: (unsigned long long=
)0, signed long long: (unsigned long long)0, default: (0ULL))))(~0ull))))) =
__compiletime_assert_464(); } while (0); }); (typeof(((unsigned long)(((int=
)sizeof(struct {_Static_assert(!(__builtin_choose_expr((sizeof(int) =3D=3D =
sizeof(*(8 ? ((void *)((long)((0) > (2)) * 0l)) : (int *)8))), (0) > (2), f=
alse)), "const_true((0) > (2))" " is true");})) + (((typeof(unsigned long))=
((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((ty=
peof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeof(un=
signed long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned=
 long))(-1)) < ( typeof(unsigned long))1))))) << (0) & ((typeof(unsigned lo=
ng))((((typeof(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (=
((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1))) - 1) + ((typeo=
f(unsigned long))1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsi=
gned long))(-1)) < ( typeof(unsigned long))1))))) >> ((sizeof(unsigned long=
) * 8) - 1 - (2)))))))((((unsigned long)(((int)sizeof(struct {_Static_asser=
t(!(__builtin_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)=
((0) > (2)) * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2)=
)" " is true");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 <=
< (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < (=
 typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(t=
ypeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsig=
ned long))1))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long)=
)1 << (8*sizeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1))=
 < ( typeof(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*size=
of(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(u=
nsigned long))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) >> (__b=
uiltin_ffsll(((unsigned long)(((int)sizeof(struct {_Static_assert(!(__built=
in_choose_expr((sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((0) > (2))=
 * 0l)) : (int *)8))), (0) > (2), false)), "const_true((0) > (2))" " is tru=
e");})) + (((typeof(unsigned long))((((typeof(unsigned long))1 << (8*sizeof=
(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(uns=
igned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(unsig=
ned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned long))1=
))))) << (0) & ((typeof(unsigned long))((((typeof(unsigned long))1 << (8*si=
zeof(typeof(unsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof=
(unsigned long))1))) - 1) + ((typeof(unsigned long))1 << (8*sizeof(typeof(u=
nsigned long)) - 1 - (((typeof(unsigned long))(-1)) < ( typeof(unsigned lon=
g))1))))) >> ((sizeof(unsigned long) * 8) - 1 - (2)))))) - 1)); }) + 1) )),=
 txfifo_order) signedness error
     706 |         _compiletime_assert(condition, msg, __compiletime_assert=
_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:687:25: note: in definition of macro '__c=
ompiletime_assert'
     687 |                         prefix ## suffix();                     =
        \
         |                         ^~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_comp=
iletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert=
_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletim=
e_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), =
msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
      93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_=
once'
      98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_I=
D(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cm=
p'
     105 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/spi/spi-fsl-lpspi.c:997:32: note: in expansion of macro 'min'
     997 |                 txfifo_order =3D min(TXFIFO_ORDER_MAX, txfifo_or=
der);
         |                                ^~~


vim +706 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  692 =20
eb5c2d4b45e3d2d Will Deacon 2020-07-21  693  #define _compiletime_assert(co=
ndition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  694  	__compiletime_assert(conditio=
n, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  695 =20
eb5c2d4b45e3d2d Will Deacon 2020-07-21  696  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  697   * compiletime_assert - break =
build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  698   * @condition: a compile-time =
constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  699   * @msg:       a message to em=
it if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  700   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  701   * In tradition of POSIX asser=
t, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  702   * supplied condition is *fals=
e*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  703   * compiler has support to do =
so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  704   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  705  #define compiletime_assert(con=
dition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @706  	_compiletime_assert(condition=
, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  707 =20

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
