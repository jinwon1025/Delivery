<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="card">
    <div class="card-header">
        <h5 class="mb-0"><i class="fas fa-coins"></i> 포인트 적립률 설정</h5>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <form id="pointRateForm" action="/admin/updatePointRate" method="post">
                    <div class="mb-4">
                        <label for="currentRate" class="form-label">현재 포인트 적립률</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="currentRate" value="${currentRate}" readonly>
                            <span class="input-group-text">%</span>
                        </div>
                        <small class="text-muted">* 현재 주문 금액의 ${currentRate}%가 포인트로 적립됩니다.</small>
                    </div>
                    
                    <div class="mb-4">
                        <label for="newRate" class="form-label">새 포인트 적립률</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="newRate" name="pointRate" step="0.1" min="0" max="10" required>
                            <span class="input-group-text">%</span>
                        </div>
                        <small class="text-muted">* 적립률은 0% ~ 10% 사이로 설정 가능합니다.</small>
                    </div>
                    
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">적립률 변경하기</button>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="row mt-5">
            <div class="col-md-8 mx-auto">
                <div class="card border-info">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="fas fa-info-circle"></i> 포인트 적립률 안내</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">포인트 적립률은 주문 금액 대비 적립되는 포인트의 비율입니다.</li>
                            <li class="list-group-item">예: 적립률 2%일 경우, 10,000원 주문 시 200포인트가 적립됩니다.</li>
                            <li class="list-group-item">적립률 변경 시 즉시 반영되며, 이후 발생하는 모든 주문에 적용됩니다.</li>
                            <li class="list-group-item">주문 취소 시 적립된 포인트는 자동으로 차감됩니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.getElementById('pointRateForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const newRate = document.getElementById('newRate').value;
    
    if (!newRate || newRate < 0 || newRate > 10) {
        alert('적립률은 0%에서 10% 사이로 설정해주세요.');
        return;
    }
    
    if (confirm('포인트 적립률을 ' + newRate + '%로 변경하시겠습니까?')) {
        this.submit();
    }
});
</script>